# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company =  Company.create({
  description: '',
  name: 'Shopify',
  link: 'http://campusperks.ca/'
})
company.save

company =  Company.create({
  description: '',
  name: 'Redwood Strategic Inc.',
  link: 'http://campusperks.ca/'
})
company.save

10.times do 
  job = Job.create({
    country: 'Canada',
    city: 'Toronto',
    deadline: 'Rolling Basis',
    province: 'Ontario',
    title: 'Senior Ruby on Rails Software Developer'
  })

  job.company = company
  job.save
end