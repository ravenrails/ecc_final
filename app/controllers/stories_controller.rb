class StoriesController < ApplicationController
  before_filter :setRelease

  def index
    @stories = @release.stories.all
  end

  def new
    @story = @release.stories.build
 end

  def create
   @story = @release.stories.new params[:story]

    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to release_path(@release) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
     @story = @release.stories.find(params[:id])
  end

  def show
     @story = Story.find(params[:id])
     @comment_new = @story.comments.new
  end

  def update
     @story = @release.stories.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to release_story_path(@release, @story) }
      else
        format.html { render :action => "edit" }
      end
    end
  end  
  
  def destroy
    story = Story.find(params[:id])
    story.destroy
    
    respond_to do |format|
      @stories = @release.stories
      format.js   { render 'list' }
    end
  end
  
  private
    
    def setRelease
      @release = Release.find params[:release_id]
    end
end

