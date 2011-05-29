class Admin::ProjectsController < ApplicationController

  before_filter :authenticate_admin!
  
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
        format.html { redirect_to( admin_project_path( @project ), 
                      :notice => 'Project was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    set_member_vars(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to( admin_project_path( @project ), 
                      :notice => 'Project was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def add_member
    params[:member].each do |member|
      params[:role].each do |role|
        ProjectMember.create(
          :project_id => params[:project_id],
          :user_id => member,
          :role_id => role
        )
      end
    end

    set_member_vars(params[:project_id])

    respond_to do |format|
      format.js do
        render 'members'
      end
    end
  end

  def update_member
    ProjectMember.where(:project_id => params[:project_id], 
                        :user_id => params[:id]).destroy_all
    
    params[:role].each do |role|
      ProjectMember.create(
        :project_id => params[:project_id],
        :user_id => params[:id],
        :role_id => role
      )
    end

    set_member_vars(params[:project_id])

    respond_to do |format|
      format.js do
        render 'members'
      end
    end
  end

  def remove_member
    ProjectMember.where(:project_id => params[:project_id], 
                        :user_id => params[:id]).destroy_all

    set_member_vars(params[:project_id])

    respond_to do |format|
      format.js do
        render 'members'
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.js do
        render :text => params[:id]
      end
    end
  end
  
  private
    
    def set_member_vars(project_id)      
      @project = Project.find(project_id)
      @members = @project.project_members
      
      member_ids = @members.reduce('') do |x, y| 
        x << (x.empty? ? '': ', ') << y.user_id.to_s 
      end
      
      @users = User.where("id NOT IN(#{member_ids})")
      @roles = Role.all
    end
    
end
