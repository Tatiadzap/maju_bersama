# db/seeds.rb
require 'faker'

puts "Clearing existing records"

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
10.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    encrypted_password: 'password',
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code,
    country: Faker::Address.country,
    profile_picture: Faker::Avatar.image,
    bio: Faker::Lorem.paragraph,
    role: %w[candidate employer].sample
  )
end

# Create Employers
employers = []
users.select { |u| u.role == 'employer' }.each do |user|
  employers << Employer.create!(
    user_id: user.id,
    company_name: Faker::Company.name,
    company_description: Faker::Company.catch_phrase,
    website: Faker::Internet.url,
    industry: Faker::Company.industry
  )
end

# Create Jobs
jobs = []
employers.each do |employer|
  5.times do
    jobs << Job.create!(
      employer_id: employer.id,
      title: Faker::Job.title,
      description: Faker::Job.field,
      location: Faker::Address.city,
      requirements: Faker::Job.key_skill
    )
  end
end

# Create Events
events = []
employers.each do |employer|
  3.times do
    events << Event.create!(
      employer_id: employer.id,
      name: Faker::Event.name,
      description: Faker::Lorem.sentence,
      location: Faker::Address.full_address,
      start_time: Faker::Time.forward(days: 10),
      end_time: Faker::Time.forward(days: 12)
    )
  end
end

# Create Applications
applications = []
users.select { |u| u.role == 'candidate' }.each do |user|
  jobs.sample(3).each do |job|
    applications << Application.create!(
      user_id: user.id,
      job_id: job.id,
      status: %w[Applied Interviewed Rejected Accepted].sample,
      applied_at: Faker::Time.backward(days: 30)
    )
  end
end

# Create Candidates
candidates = []
users.select { |u| u.role == 'candidate' }.each do |user|
  candidates << Candidate.create!(
    user_id: user.id,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    resume: Faker::File.file_name(dir: 'resumes', ext: 'pdf'),
    date_of_birth: Faker::Date.birthday(min_age: 22, max_age: 55),
    languages: Faker::Languages.language
  )
end

# Create Skills
skills = []
10.times do
  skills << Skill.create!(
    skill_name: Faker::Job.key_skill
  )
end

# Associate Skills with Candidates
candidates.each do |candidate|
  skills.sample(5).each do |skill|
    CandidateSkill.create!(
      candidate_id: candidate.id,
      skill_id: skill.id
    )
  end
end

# Create Experiences
experiences = []
candidates.each do |candidate|
  3.times do
    experiences << Experience.create!(
      candidate_id: candidate.id,
      job_title: Faker::Job.title,
      company_name: Faker::Company.name,
      start_date: Faker::Date.backward(days: 365 * 5),
      end_date: Faker::Date.backward(days: 365 * 2),
      description: Faker::Lorem.sentence
    )
  end
end

# Create Educations
educations = []
candidates.each do |candidate|
  2.times do
    educations << Education.create!(
      candidate_id: candidate.id,
      institution_name: Faker::Educator.university,
      degree: Faker::Educator.degree,
      field_of_study: Faker::Educator.subject,
      start_date: Faker::Date.backward(days: 365 * 10),
      end_date: Faker::Date.backward(days: 365 * 2),
      description: Faker::Lorem.sentence
    )
  end
end

# Create Disabilities
disabilities = []
5.times do
  disabilities << Disability.create!(
    disability_name: Faker::Lorem.words(number: 2).join(' ').titleize,
    description: Faker::Lorem.paragraph
  )
end

# Associate Disabilities with Users
users.select { |u| u.role == 'candidate' }.each do |user|
  disabilities.sample(2).each do |disability|
    UserDisability.create!(
      user_id: user.id,
      disability_id: disability.id,
      details: Faker::Lorem.sentence
    )
  end
end

# Create Event Registrations
event_registrations = []
users.select { |u| u.role == 'candidate' }.each do |user|
  events.sample(3).each do |event|
    event_registrations << EventRegistration.create!(
      user_id: user.id,
      event_id: event.id,
      registered_at: Faker::Time.backward(days: 30)
    )
  end
end

puts "Seed data created successfully!"
