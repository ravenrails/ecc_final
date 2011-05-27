class ReleasesController < ApplicationController
  before_filter :set_project

  def show
    @release = Release.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @release }
    end
  end

  def new
    @release = @project.releases.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @release }
    end
  end

  def edit
    @release = Release.find(params[:id])
  end

  def create
    @release = @project.releases.new(params[:release])

    respond_to do |format|
      if @release.save
        format.html { redirect_to(@release, :notice => 'Release was successfully created.') }
        format.xml  { render :xml => @release, :status => :created, :location => @release }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @release = Release.find(params[:id])
    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to(@release, :notice => 'Release was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @release = Release.find(params[:id])
    @release.destroy
    respond_to do |format|
      format.html { redirect_to(releases_url) }
      format.xml  { head :ok }
    end
  end

  private

    def set_project
      @project = Project.find params[:project_id]
    end
end
