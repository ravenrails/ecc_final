class Admin::HomeController < ApplicationController

  def index
    @admins = User.all
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(params[:user])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admin_path(@admin.id), :notice => 'Admin user was successfully created.') }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @admin = User.find(params[:id])
  end

  def show
    @admin = User.find(params[:id])
  end

  def update
    @admin = User.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:user])
        format.html { redirect_to(admins_path, :notice => 'Admin user was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end
end
