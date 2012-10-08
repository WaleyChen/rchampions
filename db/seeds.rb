# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Specify JOBS=nn when invoking to request creation of more user accounts. 
# Example:
#   bundle exec rake db:reseed JOBS=20

require 'faker'

job = Job.create({
 country: 'Canada'
})
job.save

