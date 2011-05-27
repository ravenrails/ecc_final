class CommentsController < ApplicationController

  def create
    @release = Release.find params[:release_id]
    @story = @release.stories.find params[:story_id]
    @comment = @story.comments.build(   :content      => params[:content],
                                        :comment_date => Time.now)
    @comment.save

    respond_to do | format |
      format.html {redirect_to release_story_path(@release, @story)}
      format.js
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

