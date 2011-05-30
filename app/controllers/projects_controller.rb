class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @projects = current_user.all_projects
  end

  #def new
  #  @project = Project.new
  #end

  #def edit
  #  @project = Project.find(params[:id])
  #end

  def show
    @project        = current_user.projects.find(params[:id])
    @releases       = @project.releases
    @proj_owners    = @project.project_members.owner
    @proj_managers  = @project.project_members.manager
    @proj_members   = @project.all_members
    #render :text => current_user.id
  end

  #def create
  # @project = Project.new(params[:project])
  #
  #  respond_to do |format|
  #   if @project.save
  #      format.html { redirect_to(project_path(@project.id), :notice => 'Project was successfully created.') }
  #      format.xml  { render :xml => @project, :status => :created, :location => @project }
  #    else
  #      format.html { render :action => "new" }
  #      format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

 # def update
  #  @project = User.find(params[:id])
#
 #   respond_to do |format|
  #    if @project.update_attributes(params[:user])
   #     format.html { redirect_to(projects_path, :notice => 'Project was successfully updated.') }
   #     format.xml  { head :ok }
    #  else
     #   format.html { render :action => "edit" }
      #  format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
 #     end
    #end
  #end

end

