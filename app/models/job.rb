class Job
  include Mongoid::Document

  field :apply_link
  field :city
  field :country
  field :deadline, :default => ''
  field :description
  field :province # a.k.a. state
  field :requirements
  field :tags
  field :title

  # attr_accessor :title

  belongs_to :company
end