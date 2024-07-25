# frozen_string_literal: true

# Clear existing records
User.destroy_all
Employer.destroy_all
Job.destroy_all
Event.destroy_all
Application.destroy_all
Candidate.destroy_all
Skill.destroy_all
CandidateSkill.destroy_all
Experience.destroy_all
Education.destroy_all
Disability.destroy_all
UserDisability.destroy_all
EventRegistration.destroy_all

# Create Users
users = []
users << User.create!(email: 'alice.smith@example.com', password: 'password', password_confirmation: 'password', phone: '555-1234', address: '123 Elm Street', city: 'Springfield', state: 'IL', zip_code: '62701', country: 'USA', profile_picture: 'alice_profile.png', bio: 'Software developer with 5 years of experience in full stack development.', role: 'candidate')
users << User.create!(email: 'bob.johnson@example.com', password: 'password', password_confirmation: 'password', phone: '555-5678', address: '456 Oak Avenue', city: 'Springfield', state: 'IL', zip_code: '62701', country: 'USA', profile_picture: 'bob_profile.png', bio: 'Experienced project manager with a focus on Agile methodologies.', role: 'employer')
users << User.create!(email: 'carol.williams@example.com', password: 'password', password_confirmation: 'password', phone: '555-8765', address: '789 Pine Road', city: 'Springfield', state: 'IL', zip_code: '62701', country: 'USA', profile_picture: 'carol_profile.png', bio: 'UX designer with a passion for creating user-friendly interfaces.', role: 'candidate')
users << User.create!(email: 'david.brown@example.com', password: 'password', password_confirmation: 'password', phone: '555-4321', address: '101 Maple Street', city: 'Springfield', state: 'IL', zip_code: '62701', country: 'USA', profile_picture: 'david_profile.png', bio: 'Digital marketing expert with experience in SEO and content strategy.', role: 'employer')

# Create Employers
employers = []
users.select { |u| u.role == 'employer' }.each do |user|
  employers << Employer.create!(user_id: user.id, company_name: 'Tech Innovators Inc.', company_description: 'Leading company in technology solutions and innovation.', website: 'https://techinnovators.com', industry: 'Technology')
end

# Create Jobs
jobs = []
employers.each do |employer|
  jobs << Job.create!(employer_id: employer.id, title: 'Full Stack Developer', description: 'Responsible for developing both front-end and back-end components.', location: 'Chicago, IL', requirements: '3+ years experience with JavaScript, Ruby on Rails, and SQL.')
  jobs << Job.create!(employer_id: employer.id, title: 'Product Manager', description: 'Manage product lifecycle from conception to launch.', location: 'Chicago, IL', requirements: '5+ years experience in project management and Agile methodologies.')
end

# Create Events
events = []
events << Event.create!(employer_id: employers.first.id, name: 'Introduction to Full Stack Web Development', description: 'A comprehensive workshop covering HTML, CSS, JavaScript, and backend technologies.', location: 'Online', start_time: DateTime.new(2024, 8, 10, 9, 0, 0), end_time: DateTime.new(2024, 8, 12, 17, 0, 0))
events << Event.create!(employer_id: employers.first.id, name: 'Data Science Essentials', description: 'An in-depth workshop on data analysis, statistical methods, and machine learning basics.', location: 'San Francisco, CA', start_time: DateTime.new(2024, 9, 5, 10, 0, 0), end_time: DateTime.new(2024, 9, 7, 16, 0, 0))
events << Event.create!(employer_id: employers.last.id, name: 'UX Design Fundamentals', description: 'A hands-on workshop focusing on user experience design principles, prototyping, and user testing.', location: 'Chicago, IL', start_time: DateTime.new(2024, 7, 15, 9, 0, 0), end_time: DateTime.new(2024, 7, 17, 17, 0, 0))
events << Event.create!(employer_id: employers.last.id, name: 'Digital Marketing Strategies', description: 'An intensive workshop covering SEO, content marketing, and social media strategies.', location: 'New York, NY', start_time: DateTime.new(2024, 9, 12, 9, 0, 0), end_time: DateTime.new(2024, 9, 14, 17, 0, 0))

# Create Applications
applications = []
users.select { |u| u.role == 'candidate' }.each do |user|
  jobs.sample(2).each do |job|
    applications << Application.create!(user_id: user.id, job_id: job.id, status: 'Applied', applied_at: DateTime.now)
  end
end

# Create Candidates
candidates = []
users.select { |u| u.role == 'candidate' }.each do |user|
  candidates << Candidate.create!(user_id: user.id, first_name: user.email.split('@').first.capitalize, last_name: 'Doe', resume: 'resume.pdf', date_of_birth: Date.new(1990, 1, 1), languages: 'English, Spanish')
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
  experiences << Experience.create!(candidate_id: candidate.id, job_title: 'Junior Developer', company_name: 'Web Solutions LLC', start_date: Date.new(2019, 6, 1), end_date: Date.new(2021, 5, 31), description: 'Worked on web application development using JavaScript and Ruby on Rails.')
  experiences << Experience.create!(candidate_id: candidate.id, job_title: 'Senior Developer', company_name: 'Tech Innovators Inc.', start_date: Date.new(2021, 6, 1), end_date: Date.new(2023, 7, 31), description: 'Led the development team for multiple full-stack projects.')
end

# Create Educations
educations = []
candidates.each do |candidate|
  educations << Education.create!(candidate_id: candidate.id, institution_name: 'University of Illinois', degree: 'Bachelor of Science', field_of_study: 'Computer Science', start_date: Date.new(2012, 8, 1), end_date: Date.new(2016, 5, 31), description: 'Focused on software engineering and web development.')
  educations << Education.create!(candidate_id: candidate.id, institution_name: 'Tech Academy', degree: 'Certificate', field_of_study: 'Full Stack Development', start_date: Date.new(2017, 1, 1), end_date: Date.new(2017, 12, 31), description: 'Completed intensive coding bootcamp covering full stack web development.')
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
