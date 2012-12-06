class MediaCompany
  COMPANY_NAME = 'Media Company'
  HACKER = []
  HUSTLER = []
  DESIGNER = [
    {
      title: 'Web/3D/Flash/Visual Effect/Editor Internships',
      apply_link: 'http://toronto.kijiji.ca/c-jobs-graphic-web-design-Web-3D-Flash-Visual-Effect-Editor-Internships-W0QQAdIdZ437671669',
      country: 'CA',
      state: 'ON',
      city: 'Toronto'       
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