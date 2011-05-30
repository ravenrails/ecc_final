class Admin::HomeController < ApplicationController

  before_filter :authenticate_admin!

  def index
    render :action => 'my_account'
  end

  def new
    @admin = User.new
  end

  def create
    @admin = User.new(params[:user])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admin_path(@admin.id), :notice => 'Admin user was successfully created.') }
      else
        format.html { render :action => "new" }
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
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def my_account
  end

  def change_password
  end

  def update_account
    respond_to do |format|
      if current_admin.update_attributes(params[:admin])
        format.html { redirect_to eval('admin_' + params[:from] + '_path') }
      else
        format.html { render :action => params[:from] }
      end
    end
  end
end
