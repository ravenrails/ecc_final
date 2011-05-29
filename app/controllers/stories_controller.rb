class StoriesController < ApplicationController
  before_filter :set_release, :except => 'add_rating'

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
        save_tags @story
        
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to release_story_path(@release, @story) }
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
        save_tags @story
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
  
  def add_rating
    story = Story.find(params[:story_id])
    story.ratings.create :rate => params[:rate] #, :user_id => session[:user_id]
    
    respond_to do |format|
      format.js do
        render :text => %[$('#rating-div').html("<em>Average Rating: #{story.ratings.average(:rate)}</em>")] 
      end
    end
  end
  
  private
    
    def set_release
      @release = Release.find params[:release_id]
    end
    
    def save_tags(story)
      tags = params[:tags].split ','
      project_id = story.release.project.id
            
      TagRelation.relate Tag.save_tag(tags, project_id), story.id
    end
end

