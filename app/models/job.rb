class Job
  include Mongoid::Document

  field :apply_link
  field :city
  field :country
  field :deadline
  field :description
  field :province # a.k.a. state
  field :requirements
  field :tags
  field :title

  belongs_to :company
end