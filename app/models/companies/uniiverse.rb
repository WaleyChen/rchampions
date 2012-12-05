class Uniiverse
   HACKER = []
   HUSTLER = [
      {
         title: 'Marketing Ambassador',
         startup_type: 'Hustler',
         apply_link: 'https://www.uniiverse.com/internship',
         country: 'CA',
         state: 'ON',
         city: 'Toronto'       
      },
      {
         title: 'Marketing Lead',
         startup_type: 'Hustler',
         apply_link: 'https://www.uniiverse.com/positions/marketing-lead',
         country: 'CA',
         state: 'ON',
         city: 'Toronto'       
      },
      {
         title: 'Social Media Lead',
         startup_type: 'Hustler',
         apply_link: 'https://www.uniiverse.com/positions/social-media-lead',
         country: 'CA',
         state: 'ON',
         city: 'Toronto'       
      }
   ]
   DESIGNER = []

  def self.seed
    Company.where(:name => 'Uniiverse').all.destroy
    Job.where(:company_name => 'Uniiverse').all.destroy

    company =  Company.create({
      description: '',
      name: 'Uniiverse',
      link: 'https://www.uniiverse.com/'
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