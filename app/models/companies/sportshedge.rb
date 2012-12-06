class SportsHedge
  COMPANY_NAME = 'SportsHedge'
  HACKER = []
  HUSTLER = []
  DESIGNER = [
    {
      title: 'Graphic Designer',
      apply_link: 'http://toronto.kijiji.ca/c-jobs-graphic-web-design-Startup-Internship-Graphic-Designer-W0QQAdIdZ430961738',
      country: 'CA',
      state: 'ON',
      city: 'Mississauga'       
    }
  ]

  def self.seed
    Company.where(:name => COMPANY_NAME).all.destroy
    Job.where(:company_name => COMPANY_NAME).all.destroy

    company =  Company.create({
      description: '',
      name: COMPANY_NAME
    })
    company.save

    HACKER.each do |hacker|
      job = Job.create(hacker)
      job.startup_type = 'Hacker'
      job.in_newsletter = true
      job.company = company
      job.save
    end

    HUSTLER.each do |hustler|
      job = Job.create(hustler)
      job.startup_type = 'Hustler'
      job.in_newsletter = true
      job.company = company
      job.save
    end

    DESIGNER.each do |designer|
      job = Job.create(designer)
      job.startup_type = 'Designer'
      job.in_newsletter = true
      job.company = company
      job.save
    end
  end
end