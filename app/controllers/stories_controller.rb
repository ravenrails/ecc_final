class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])

    respond_to do |format|
      if @story.save
        format.html { redirect_to(story_path(@story.id), :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def show
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        format.html { redirect_to(stories_path, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end
end

