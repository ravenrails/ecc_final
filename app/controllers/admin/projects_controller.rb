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
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @project = Project.find(params[:id])
    @members = @project.project_members
    @users = User.all
    @roles = Role.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
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
        :role_id => params[:role].reduce('') { |x, s| x << (x.empty? ? '': '-') << s }
      )
    end

    respond_to do |format|
      format.js do
        @members = Project.find(params[:id]).members
        render :update do |page|
          page.replace_html 'project-members', :partial => 'members'
        end
      end
    end
  end

end
