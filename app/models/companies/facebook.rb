class Facebook
   Hacker = [
      {
         title: 'CERT Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000Ea8aMAC',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'eCrime Analyst Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EZYSMA4',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Front End Engineer, Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EXI8MAO',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Product Security Internship',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EZYNMA4',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Production Engineer, Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000E4DqMAK',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Security Engineering Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000Ea8fMAC',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Security Engineering Research Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EVh1MAG',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Software Engineer, Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000E5pbMAC',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'
      },
      {
         title: 'Software Engineer, Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000E5pbMAC',
         country: 'US',
         state: 'WA',
         city: 'Seattle'
      }
   ]

   Hustler = [
      {
         title: 'University Business Intern: Account Management',
         startup_type: 'Hustler',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000Ec9EMAS',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      },
      {
         title: 'University Business Intern: Corporate Communications & Public Policy',
         startup_type: 'Hustler',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EaqDMAS',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      },
      {
         title: 'Marketplace Analyst Intern, Monetization',
         startup_type: 'Hustler',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EO2qMAG',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      },
      {
         title: 'University Business Intern: Direct Sales, Sales Operations',
         startup_type: 'Hustler',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EaqrMAC',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      },
      {
         title: 'University Business Intern: Global Agency Team (New York)',
         startup_type: 'Hustler',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EapZMAS',
         country: 'US',
         state: 'NY',
         city: 'New York'       
      },
      {
         title: 'UEX Researcher, Intern',
         startup_type: 'Hacker',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EDz5MAG',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      }
   ]

   Designer = [
      {
         title: 'Product Design, Intern',
         startup_type: 'Designer',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000LqzUMAS',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      },
      {
         title: 'UEX Researcher, Intern',
         startup_type: 'Designer',
         apply_link: 'http://www.facebook.com/careers/department?dept=interns&req=a2KA0000000EDz5MAG',
         country: 'US',
         state: 'CA',
         city: 'Menlo Park'       
      }
   ]

  def self.seed
    Company.where(:name => 'Facebook').all.destroy
    Job.where(:company_name => 'Facebook').all.destroy

    company =  Company.create({
      description: '',
      name: 'Facebook',
      link: 'http://www.facebook.com/'
    })
    company.save

    Hacker.each do |hacker|
      job = Job.create(hacker)
      job.in_newsletter = true
      job.company = company
      job.save
    end

    Hustler.each do |hustler|
      job = Job.create(hustler)
      job.in_newsletter = true
      job.company = company
      job.save
    end

    Designer.each do |designer|
      job = Job.create(designer)
      job.in_newsletter = true
      job.company = company
      job.save
    end
  end
end