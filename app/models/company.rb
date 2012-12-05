class Company
  include Mongoid::Document

  field :description
  field :link
  field :name, :default => ''

  has_many :jobs
end