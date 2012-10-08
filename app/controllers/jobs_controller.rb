class JobsController < ApplicationController

  def create
    @job = Job.new
    
    respond_to do |format|
      format.js{ render :none => true }
    end
  end

  def index
    respond_to do |format|
      format.js{ render :none => true }
    end
  end

  def new
    @job = Job.new
  end
end
