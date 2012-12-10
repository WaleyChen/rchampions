class NewsletterSubscriber
  include Mongoid::Document

  field :email
  field :jobs_interested_in
end