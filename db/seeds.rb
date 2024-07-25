# frozen_string_literal: true

require 'faker'

# Reset primary key sequences and clear existing records
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations' # Skip schema_migrations table

  # Truncate table to clear all records
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
end

# Define static data for employers and events
company_names = ['Tech Innovators Inc.', 'Creative Solutions LLC', 'NextGen Technologies', 'BrightFuture Enterprises']
company_descriptions = [
  'Leading company in technology solutions and innovation.',
  'Creative agency specializing in design and development.',
  'Innovative firm focusing on the future of technology.',
  'Dynamic enterprise dedicated to shaping the future.'
]
industries = ['Technology', 'Design', 'Consulting', 'Education']
event_names = ['Introduction to Full Stack Web Development', 'Data Science Essentials', 'UX Design Fundamentals', 'Digital Marketing Strategies']
event_descriptions = [
  'A comprehensive workshop covering HTML, CSS, JavaScript, and backend technologies.',
  'An in-depth workshop on data analysis, statistical methods, and machine learning basics.',
  'A hands-on workshop focusing on user experience design principles, prototyping, and user testing.',
  'An intensive workshop covering SEO, content marketing, and social media strategies.'
]
locations = ['Online', 'San Francisco, CA', 'Chicago, IL', 'New York, NY']

# Create Users
users = []
users << User.create!(email: 'alice.smith@example.com', password: 'password', password_confirmation: 'password', phone: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, country: 'USA', profile_picture: 'alice_profile.png', bio: Faker::Lorem.sentence, role: 'candidate')
users << User.create!(email: 'bob.johnson@example.com', password: 'password', password_confirmation: 'password', phone: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, country: 'USA', profile_picture: 'bob_profile.png', bio: Faker::Lorem.sentence, role: 'employer')
users << User.create!(email: 'carol.williams@example.com', password: 'password', password_confirmation: 'password', phone: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, country: 'USA', profile_picture: 'carol_profile.png', bio: Faker::Lorem.sentence, role: 'candidate')
users << User.create!(email: 'david.brown@example.com', password: 'password', password_confirmation: 'password', phone: Faker::PhoneNumber.phone_number, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, country: 'USA', profile_picture: 'david_profile.png', bio: Faker::Lorem.sentence, role: 'employer')

# Create Employers
employers = []
users.select { |u| u.role == 'employer' }.each do |user|
  employers << Employer.create!(
    user_id: user.id,
    company_name: company_names.sample,
    company_description: company_descriptions.sample,
    website: Faker::Internet.url,
    industry: industries.sample
  )
end

# Create Jobs
jobs = []
employers.each do |employer|
  jobs << Job.create!(employer_id: employer.id, title: Faker::Job.title, description: Faker::Job.field, location: Faker::Address.city, requirements: Faker::Job.key_skill)
  jobs << Job.create!(employer_id: employer.id, title: Faker::Job.title, description: Faker::Job.field, location: Faker::Address.city, requirements: Faker::Job.key_skill)
end

# Create Events
events = []
locations.each do |location|
  events << Event.create!(
    employer_id: employers.sample.id,
    name: event_names.sample,
    description: event_descriptions.sample,
    location: location,
    start_time: Faker::Date.forward(days: 30),
    end_time: Faker::Date.forward(days: 35)
  )
end

# Create Applications
job_applications = []
users.select { |u| u.role == 'candidate' }.each do |user|
  jobs.sample(2).each do |job|
    job_applications << JobApplication.create!(user_id: user.id, job_id: job.id, status: 'Applied', applied_at: DateTime.now)
  end
end

# Create Candidates
candidates = []
users.select { |u| u.role == 'candidate' }.each do |user|
  candidates << Candidate.create!(
    user_id: user.id,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    resume: 'resume.pdf',
    date_of_birth: Faker::Date.birthday(min_age: 22, max_age: 50),
    languages: 'English, Spanish' # Assuming candidates speak English and Spanish
  )
end

# Create Skills
skills = []
skills << Skill.create!(skill_name: 'JavaScript')
skills << Skill.create!(skill_name: 'Ruby on Rails')
skills << Skill.create!(skill_name: 'Project Management')
skills << Skill.create!(skill_name: 'UX Design')
skills << Skill.create!(skill_name: 'SEO')

# Associate Skills with Candidates
candidates.each do |candidate|
  skills.sample(3).each do |skill|
    CandidateSkill.create!(candidate_id: candidate.id, skill_id: skill.id)
  end
end

# Create Experiences
experiences = []
candidates.each do |candidate|
  experiences << Experience.create!(candidate_id: candidate.id, job_title: Faker::Job.title, company_name: Faker::Company.name, start_date: Faker::Date.backward(days: 1000), end_date: Faker::Date.backward(days: 500), description: Faker::Lorem.paragraph)
  experiences << Experience.create!(candidate_id: candidate.id, job_title: Faker::Job.title, company_name: Faker::Company.name, start_date: Faker::Date.backward(days: 500), end_date: Faker::Date.backward(days: 100), description: Faker::Lorem.paragraph)
end

# Create Educations
educations = []
candidates.each do |candidate|
  educations << Education.create!(
    candidate_id: candidate.id,
    institution_name: Faker::University.name,
    degree: ['Bachelor of Science', 'Master of Science', 'PhD'].sample,
    field_of_study: ['Computer Science', 'Software Engineering', 'Data Science'].sample,
    start_date: Faker::Date.backward(days: 2000),
    end_date: Faker::Date.backward(days: 1000),
    description: Faker::Lorem.paragraph
  )
  educations << Education.create!(
    candidate_id: candidate.id,
    institution_name: Faker::University.name,
    degree: ['Certificate', 'Diploma'].sample,
    field_of_study: ['Full Stack Development', 'Web Design', 'Digital Marketing'].sample,
    start_date: Faker::Date.backward(days: 1500),
    end_date: Faker::Date.backward(days: 500),
    description: Faker::Lorem.paragraph
  )
end

# Create Disabilities
disabilities = []
disabilities << Disability.create!(disability_name: 'Blindness', description: 'Complete loss of vision.')
disabilities << Disability.create!(disability_name: 'Deafness', description: 'Complete loss of hearing.')
disabilities << Disability.create!(disability_name: 'Color Blindness', description: 'Difficulty distinguishing between certain colors.')
disabilities << Disability.create!(disability_name: 'Mobility Impairment', description: 'Limited ability to move or perform physical tasks.')

# Associate Disabilities with Users
users.select { |u| u.role == 'candidate' }.each do |user|
  disabilities.sample(1).each do |disability|
    UserDisability.create!(user_id: user.id, disability_id: disability.id, details: 'Has accommodations and tools in place to assist with disability.')
  end
end

# Create Event Registrations
event_registrations = []
users.select { |u| u.role == 'candidate' }.each do |user|
  events.sample(2).each do |event|
    EventRegistration.create!(user_id: user.id, event_id: event.id, registered_at: DateTime.now)
  end
end

puts "Seed data created successfully!"
