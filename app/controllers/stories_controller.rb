class StoriesController < ApplicationController
  before_filter :initialfind

  def initialfind
    @release = Release.find params[:release_id]
  end

  def index
    @stories = @release.stories.all
  end

  def new
    @story = @release.stories.build
 end

  def create
   @story = @release.stories.build params[:story]

    respond_to do |format|
      if @story.save
        format.html { redirect_to(release_path(@release), :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
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
     @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(release_story_path, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end
end

