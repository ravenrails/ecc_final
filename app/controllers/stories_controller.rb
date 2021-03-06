class StoriesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_release, :except => :add_rating
  before_filter :is_authorize, :except => [ :show, :add_rating, :update_status ]

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
     @story = @release.stories.find(params[:id])
     @comments = @story.comments
  end

  def update_status
    @story = @release.stories.find(params[:story_id])

    Story.save_status(@story, params[:status])

    respond_to do |format|
      format.js
    end
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
    story = @release.stories.find(params[:id])
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
        render :text => %[$('#actual-rating').html("#{story.ratings.average(:rate)}")]
      end
    end
  end

  private

    def set_release
      @release = Release.find params[:release_id]
    end

    def is_authorize
      redirect_to(projects_path) unless authorize_for_story_crud? @release
    end

    def authorize_for_story_crud?(release)
      project_owner = Role.where(:name => 'Project Owner').first
      project_manager = Role.where(:name => 'Project Manager').first

      ProjectMember.where('project_id = ? AND user_id = ? AND (role_id = ? OR role_id = ?)',
         release.project.id, current_user.id, project_owner.id, project_manager.id).count > 0
    end

    def save_tags(story)
      tags = params[:tags].split ','
      project_id = story.release.project.id

      TagRelation.relate Tag.save_tag(tags, project_id), story.id
    end
end

