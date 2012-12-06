class WaveAccounting
  COMPANY_NAME = 'Wave Accounting'
  HACKER = []
  HUSTLER = [
    {
      title: 'Marketing Intern',
      apply_link: 'http://www.waveaccounting.com/about-us/jobs/communicationmarketing-internships/',
      country: 'CA',
      state: 'ON',
      city: 'Toronto'       
    },
    {
      title: 'Writing and Research Intern',
      apply_link: 'http://www.waveaccounting.com/about-us/jobs/communicationmarketing-internships/',
      country: 'CA',
      state: 'ON',
      city: 'Toronto'       
    },
    {
      title: 'Research and Events Intern',
      apply_link: 'http://www.waveaccounting.com/about-us/jobs/communicationmarketing-internships/',
      country: 'CA',
      state: 'ON',
      city: 'Toronto'       
    }
  ]
  DESIGNER = []

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