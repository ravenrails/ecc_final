class Admin::UsersController < ApplicationController

  before_filter :authenticate_admin!

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to(admin_user_path(@admin.id), :notice => 'Admin was successfully created.') }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def show
    if params[:id].is_a? Numeric
      redirect_to 'list'
    end
    
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to(admins_path, :notice => 'Admin was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'row-' + params[:id], ''
        end
      end
      format.xml  { head :ok }
    end
  end
end
