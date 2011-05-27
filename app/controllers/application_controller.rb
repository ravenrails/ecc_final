class ApplicationController < ActionController::Base
  protect_from_forgery

  ROLES = %w[ Project Manager, Member ]
end
