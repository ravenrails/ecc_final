class MembersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @members = User.all
  end

  def new
    @member = User.new
  end

  def create
    @member = User.new(params[:user])

    respond_to do |format|
      if @member.save
        format.html { redirect_to(member_path(@member.id), :notice => 'Member was successfully created.') }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @member = User.find(params[:id])
  end

  def show
    @member = User.find(params[:id])
  end

  def update
    @member = User.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:user])
        format.html { redirect_to(members_path, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end
end
