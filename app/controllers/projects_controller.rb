class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @projects = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
  end

  def update
  end

end
