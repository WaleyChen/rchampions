# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# company =  Company.create({
#   description: '',
#   name: 'Altera',
#   link: 'http://www.altera.com/'
# })
# company.save

# job = Job.create({
#   apply_link: 'http://ch.tbe.taleo.net/CH03/ats/careers/requisition.jsp?org=ALTERA&cws=1&rid=2997',
#   description: { :description => 
#                           ["As a Software Engineer Intern, you will develop new algorithms and enhance the software infrastructure of Altera’s Quartus II CAD system. Areas of new algorithm development include physical synthesis, placement and routing, and incremental compilation techniques. These are among the most computationally difficult problems in Computer-Aided Design, and finding algorithms with better result quality and reduced CPU time is a very challenging problem. Altera’s Quartus II CAD system is a very large and full-featured software program with over 17 million lines of code, leading to many interesting software engineering questions.", 
#                           "The successful candidate's minimum qualifications will include the following:",
#                           "bulletpoint",
#                           "Working towards an undergraduate degree in Engineering Science, Electrical and Computer engineering, computer science or equivalent."] 
#                       },
#   country: 'CA',
#   city: 'Toronto',
#   deadline: 'Rolling Basis',
#   province: 'ON',
#   title: 'Software Engineer Intern'
# })

# job.company = company
# job.save

Company.where(:job_count => 0).all.destroy
Job.where(:startup_type => 'Hacker').all.destroy
Job.where(:startup_type => 'Hustler').all.destroy
Job.where(:startup_type => 'Designer').all.destroy


FiveHundredPixels.seed
Facebook.seed
MediaCompany.seed
Shopify.seed
SportsHedge.seed
Uniiverse.seed
WaveAccounting.seed

jobs = { 
  "Hacker" => Hackers::HACKERS,
  "Hustler" => Hustlers::HUSTLERS,
  "Designer" => Designers::DESIGNERS
}

jobs.each do |k, v|

  v.each do |job|
    company_name = job[:company]
    company = Company.where(:name => company_name).first

    if !company.present? && company_name.present?
      company =  Company.create({
        name: company_name
      })
      company.save
    else
      Job.where(:title => job[:title]).all.destroy
    end

    job_instance = Job.create(job.except('company'))
    job_instance.startup_type = k
    job_instance.company = company if company.present?
    job_instance.save
  end

end