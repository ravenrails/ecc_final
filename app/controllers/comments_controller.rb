class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @story = Story.find params[:story_id]
    @comments = @story.comments
    @comments.create params[:comment]

    respond_to do | format |
      format.js { render 'list' }
    end
  end

  def edit
    @release = Release.find params[:release_id]
    @story = @release.storys.find params[:story_id]
    @comment = @story.comments.find params[:id]
  end

  def update
    @release = Release.find params[:release_id]
    @story = @release.storys.find params[:story_id]
    @comment = @story.comments.find params[:id]
    if @comment.update_attributes(params[:comment])
      redirect_to release_story_path(@release, @story)
    else
     render :action => "new"
    end
  end

  def destroy
    @release = Release.find params[:release_id]
    @story = @release.storys.find params[:story_id]
    @comment = @story.comments.find params[:id]
    @comment.destroy
      redirect_to release_story_path(@release, @story)
  end
end

