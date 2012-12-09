class Company
  include Mongoid::Document

  field :description
  field :link
  field :name, :default => ''

  has_many :jobs
  field :job_count

  before_save :set_job_count

  def set_job_count
    self.job_count = self.jobs.count
  end 
end