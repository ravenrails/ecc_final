class Admin::ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to( admin_project_path( @project ), :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    # batch 1
    @project = Project.find(params[:id])
    @members = @project.project_members
    member_ids = @members.reduce('') { |x, y| x << (x.empty? ? '': ', ') << y.user_id.to_s }
    @users = User.where("id NOT IN(#{member_ids})")
    @roles = Role.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to( admin_project_path( @project ), :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_member
    params[:member].each do |member|
      ProjectMember.create(
        :project_id => params[:project_id],
        :user_id => member,
        :role_id => params[:role].reduce('') { |x, s| x << (x.empty? ? '': ', ') << s }
      )
    end

    # batch 1
    @project = Project.find(params[:project_id])
    @members = @project.project_members
    member_ids = @members.reduce('') { |x, y| x << (x.empty? ? '': ', ') << y.user_id.to_s }
    @users = User.where("id NOT IN(#{member_ids})")
    @roles = Role.all

    respond_to do |format|
      format.js do
        render 'members'
      end
    end
  end

  def update_member
    member = ProjectMember.find(params[:project_id])
    member.update_attributes( :role_id => params[:role].reduce('') { |x, s| x << (x.empty? ? '': ', ') << s } )

	# batch 1
    @project = member.project
    @members = @project.project_members
    member_ids = @members.reduce('') { |x, y| x << (x.empty? ? '': ', ') << y.user_id.to_s }
    @users = User.where("id NOT IN(#{member_ids})")
    @roles = Role.all

    respond_to do |format|
      format.js do
        render 'members'
      end
      format.xml  { head :ok }
    end
  end

  def remove_member
    member = ProjectMember.find(params[:project_id])
    member.destroy

    # batch 1
    @project = member.project
    @members = @project.project_members
    member_ids = @members.reduce('') { |x, y| x << (x.empty? ? '': ', ') << y.user_id.to_s }
    @users = User.where("id NOT IN(#{member_ids})")
    @roles = Role.all

    respond_to do |format|
      format.js do
        render 'members'
      end
      format.xml  { head :ok }
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.js do
        render :text => params[:id]
      end
      format.xml  { head :ok }
    end
  end
end
