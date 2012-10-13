class ApplicationController < ActionController::Base
  protect_from_forgery

  def aceinterns
    @jobs = Job.all
  end

  def query
    render :html => ''
  end
end
