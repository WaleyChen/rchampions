class Job
  include Mongoid::Document

  field :city
  field :company
  field :country
  field :deadline
  field :province # a.k.a. state
  field :tags
  field :title
end