# # db/seeds.rb
# require 'faker'

# # Clear existing data
# User.destroy_all
# Employer.destroy_all
# Candidate.destroy_all
# Job.destroy_all
# Event.destroy_all
# JobApplication.destroy_all
# EventRegistration.destroy_all
# Disability.destroy_all
# Experience.destroy_all
# Education.destroy_all
# Skill.destroy_all
# CandidateSkill.destroy_all
# CandidateDisability.destroy_all

# # Reset primary key sequences and clear existing records
# ActiveRecord::Base.connection.tables.each do |table|
#   next if table == 'schema_migrations' # Skip schema_migrations table

#   # Truncate table to clear all records
#   ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE;")
# end

# # Create 20 users
# puts "Creating users"
# users = []
# 5.times do
#   users << User.create!(
#     email: Faker::Internet.unique.email,
#     password: Faker::Internet.password(min_length: 10),
#     admin: false,
#     phone: Faker::PhoneNumber.cell_phone_in_e164,
#     address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     state: Faker::Address.state,
#     zip_code: Faker::Address.zip_code,
#     country: 'United States',
#     profile_picture: Faker::Avatar.image,
#     bio: Faker::Quote.most_interesting_man_in_the_world,
#     role: 'employer'
#   )
# end

# 15.times do
#   users << User.create!(
#     email: Faker::Internet.unique.email,
#     password: Faker::Internet.password(min_length: 10),
#     admin: false,
#     phone: Faker::PhoneNumber.cell_phone_in_e164,
#     address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     state: Faker::Address.state,
#     zip_code: Faker::Address.zip_code,
#     country: ['United States', 'Indonesia'].sample,
#     profile_picture: Faker::Avatar.image,
#     bio: Faker::Quote.most_interesting_man_in_the_world,
#     role: 'candidate'
#   )
# end

# # Create employers and candidates
# employers = []
# candidates = []

# puts "Assigning candidates and employers"

# users.each do |user|
#   if user.role == 'employer'
#     employers << Employer.create!(
#       user_id: user.id,
#       company_name: Faker::Company.name,
#       company_description: Faker::Company.industry,
#       website: Faker::Internet.url,
#       industry: Faker::Company.industry
#     )
#   else
#     candidates << Candidate.create!(
#       user_id: user.id,
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name,
#       resume: Faker::Internet.url,
#       date_of_birth: Faker::Date.birthday(min_age: 22, max_age: 60),
#       languages: [Faker::Nation.language, Faker::Nation.language].uniq
#     )
#   end
# end

# puts "Posting jobs"

# # Create jobs
# employers.each do |employer|
#   5.times do
#     Job.create!(
#       employer_id: employer.id,
#       title: Faker::Job.title,
#       description: Faker::Job.field,
#       location: Faker::Address.city,
#       requirements: Faker::Lorem.sentence,
#       status: 'Open'
#     )
#   end
# end

# puts "Hosting events"

# # Create events
# employers.each do |employer|
#   5.times do
#     Event.create!(
#       employer_id: employer.id,
#       name: Faker::Marketing.buzzwords,
#       description: Faker::Lorem.paragraph,
#       location: Faker::Address.city,
#       start_time: Faker::Time.forward(days: 30, period: :morning),
#       end_time: Faker::Time.forward(days: 30, period: :evening)
#     )
#   end
# end

# puts "Generating skills"

# # Create skills
# skills = []
# 20.times do
#   skills << Skill.create!(skill_name: Faker::Job.key_skill)
# end

# puts "Indexing disabilities"


# names = [
#   "Blindness",
#   "Deafness",
#   "Mobility Impairment",
#   "Cognitive Disability",
#   "Speech Impairment",
#   "Mental Health Condition",
#   "Chronic Illness",
#   "Learning Disability",
#   "Intellectual Disability",
# ]

# # Create disabilities
# disabilities = names.map do |name|
#   Disability.create!(
#     name: name,
#     description: Faker::Lorem.sentence # Use Faker for descriptions
#   )
# end

# puts "Experiences, schools and skills"

# # Create experiences, educations, and candidate skills
# candidates.each do |candidate|
#   3.times do
#     Experience.create!(
#       candidate_id: candidate.id,
#       job_title: Faker::Job.title,
#       company_name: Faker::Company.name,
#       start_date: Faker::Date.backward(days: 1000),
#       end_date: Faker::Date.backward(days: 200),
#       description: Faker::Lorem.paragraph
#     )
#   end

#   Education.create!(
#     candidate_id: candidate.id,
#     institution_name: Faker::Educator.university,
#     degree: Faker::Educator.degree,
#     field_of_study: Faker::Educator.subject,
#     start_date: Faker::Date.backward(days: 2000),
#     end_date: Faker::Date.backward(days: 1000),
#     description: Faker::Lorem.paragraph
#   )

#   2.times do
#     CandidateSkill.create!(
#       candidate_id: candidate.id,
#       skill_id: skills.sample.id
#     )
#   end

#   CandidateDisability.create!(
#     user_id: candidate.user_id,
#     disability_id: disabilities.sample.id,
#     details: Faker::Lorem.sentence
#   )
# end

# # Create job applications and event registrations
# candidates.each do |candidate|
#   2.times do
#     JobApplication.create!(
#       user_id: candidate.user_id,
#       job_id: Job.all.sample.id,
#       status: ['Applied', 'Interviewing', 'Hired'].sample,
#       applied_at: Faker::Date.backward(days: 100)
#     )
#   end

#   EventRegistration.create!(
#     user_id: candidate.user_id,
#     event_id: Event.all.sample.id,
#     registered_at: Faker::Date.backward(days: 100)
#   )
# end

# puts "Seeding db complete"

# db/seeds.rb

# Clear existing data to avoid duplicates
Disability.delete_all

# Seed data for the disabilities table
Disability.create!([
  {
    name: "Visual Impairment",
    description: "Includes partial vision loss, low vision, and total blindness."
  },
  {
    name: "Hearing Impairment",
    description: "Includes partial hearing loss and total deafness."
  },
  {
    name: "Mobility Impairment",
    description: "Includes conditions that limit movement or dexterity, such as paralysis, amputation, or arthritis."
  },
  {
    name: "Speech Impairment",
    description: "Conditions that affect an individual's ability to speak, such as stuttering, muteness, or other speech disorders."
  },
  {
    name: "Cognitive Impairment",
    description: "Includes conditions that affect cognitive functions, such as learning disabilities, traumatic brain injury, or dementia."
  },
  {
    name: "Mental Health Conditions",
    description: "Includes conditions such as anxiety disorders, depression, schizophrenia, and other mental health challenges."
  },
  {
    name: "Chronic Illness",
    description: "Includes long-term health conditions such as diabetes, epilepsy, HIV/AIDS, or chronic fatigue syndrome."
  },
  {
    name: "Autism Spectrum Disorder",
    description: "A range of neurodevelopmental disorders that affect communication, behavior, and social interaction."
  },
  {
    name: "Intellectual Disability",
    description: "A condition characterized by limitations in intellectual functioning and adaptive behavior, including Down syndrome and other similar conditions."
  },
  {
    name: "Learning Disability",
    description: "Includes dyslexia, dyscalculia, and other conditions that affect learning and academic performance."
  }
])

puts "Seeded disabilities data successfully!"
