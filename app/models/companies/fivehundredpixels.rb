class FiveHundredPixels
   HACKER = [
      {
        title: 'Software Engineer, Intern',
        startup_type: 'Hacker',
        apply_link: 'http://500px.com/jobs',
        country: 'CA',
        state: 'ON',
        city: 'Toronto'       
      }
   ]
   HUSTLER = []
   DESIGNER = []

  def self.seed
    Company.where(:name => '500px').all.destroy
    Job.where(:company_name => '500px').all.destroy

    company =  Company.create({
      description: '',
      name: '500px',
      link: 'http://500px.com/'
    })
    company.save

    HACKER.each do |hacker|
      job = Job.create(hacker)
      job.in_newsletter = true
      job.company = company
      job.save
    end

    HUSTLER.each do |hustler|
      job = Job.create(hustler)
      job.in_newsletter = true
      job.company = company
      job.save
    end

    DESIGNER.each do |designer|
      job = Job.create(designer)
      job.in_newsletter = true
      job.company = company
      job.save
    end
  end
end