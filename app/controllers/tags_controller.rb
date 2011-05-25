class TagsController < ApplicationController
  def index
    Tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @Tags }
    end
  end

  def show
    @Tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @Tag }
  end

  def edit
    Tag = Tag.find(params[:id])
  end

  def new
    @Tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @Tag }
  end

end

