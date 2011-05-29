class BacklogsController < ApplicationController

  before_filter :authenticate_user!
end
