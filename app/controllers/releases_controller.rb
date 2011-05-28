class ReleasesController < ApplicationController
  before_filter :set_project

  def show
    @release = Release.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @release }
    end
  end
  
  def edit
    @release = @project.releases.find(params[:id])
    
    respond_to do |format|
      format.js
    end
  end

  def create
    @release = @project.releases.new(params[:release])

    respond_to do |format|
      @releases = @project.releases
      if @release.save
        format.js   { render 'list' }
      else
        format.js
      end
    end
  end

  def update
    @release = Release.find(params[:id])
    respond_to do |format|
      if @release.update_attributes(params[:release])
        @releases = @project.releases
	      format.js   { render 'list' }
      else
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @release = Release.find(params[:id])
    @release.destroy
    respond_to do |format|
      @releases = @project.releases
      format.js   { render 'list' }
    end
  end

  private

    def set_project
      @project = Project.find params[:project_id]
    end
end
