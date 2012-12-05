class Job
  include Mongoid::Document

  field :apply_link
  field :city
  field :country
  field :deadline, :default => ''
  field :description
  field :in_newsletter

  field :province
  field :state

  field :requirements
  field :tags
  field :title
  field :startup_type
  field :type

  # non-job fields for sorting
  field :company_name

  belongs_to :company

  before_save :set_company_name

  def set_company_name
    return if self.company.nil?
    self.company_name = self.company.name
  end 
end