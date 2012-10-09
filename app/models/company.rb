class Company
  include Mongoid::Document

  field :description
  field :link
  field :name

  has_many :jobs
end