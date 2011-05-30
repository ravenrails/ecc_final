class HomeController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_user

  def index
  end

  def my_account
  end

  def change_password
  end

  def update_account
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to eval(params[:from] + '_home_path') }
      else
        format.html { render :action => params[:from] }
      end
    end
  end

  private

    def set_user
      @user = User.find(current_user.id)
    end
end
