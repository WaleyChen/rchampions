class Shopify
  COMPANY_NAME = 'Shopify'
  HACKER = [
    {
      title: 'Software Developer (Intern)',
      startup_type: 'Hacker',
      apply_link: 'http://www.shopify.com/careers?posting=14',
      country: 'CA',
        state: 'ON',
        city: 'Ottawa'       
      }
   ]
   HUSTLER = []
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