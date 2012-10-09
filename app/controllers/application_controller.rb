class ApplicationController < ActionController::Base
  protect_from_forgery

  def cofounderhub
    @jobs = Job.all
  end

  def query
    render :html => ''
  end
end
