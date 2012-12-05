class ApplicationController < ActionController::Base
  protect_from_forgery

  # http://beebole.com/pure/
  # get mvp out and get feedback
  # refresh the data
  # get more data
  # for the mvp, when click iframe, open a new window

  def aceinterns
    @jobs = Job.all.asc(:company_name)
  end

  def newsletter
    @hackers = Job.where(:startup_type => 'Hacker').all.to_a
    @hustlers = Job.where(:startup_type => 'Hustler').all.to_a
    @designers = Job.where(:startup_type => 'Designer').all.to_a

    @row_count = [@hackers.count, @hustlers.count, @designers.count].max

    render :layout => 'newsletter'
  end

  def query
    render :html => ''
  end
end
