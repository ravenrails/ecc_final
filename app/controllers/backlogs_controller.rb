class BacklogsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @stories = Story.where(:release_id => nil)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @story = Story.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    story = Story.find(params[:id])
  end

  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @story = Story.new params[:story]

    respond_to do |format|
      if @story.save
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to backlog_path(@story) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @story = Story.find(params[:id])

    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to backlog_path(@story) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    story = Story.find(params[:id])
    story.destroy
    
    @stories = Story.where(:release_id => nil)
    
    respond_to do |format|
      format.js { render 'list' }
    end
  end
end
