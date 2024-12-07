# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

1000.times do |i|
  puts "Creating company #{i+1}"
  company = Company.create(
    name: Faker::Company.name, 
    address: Faker::Address.full_address,
    contact: Faker::PhoneNumber.phone_number_with_country_code,
    domain: ['IT and Software Engineering', 'Accounting', 'Networking', 'Ecommerce', 'Textiles', 'Science & Engineering'].sample,
    about: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    website: "https://www.example#{i+1}.com"
  )

  puts "Creating employer #{i+1}"
  employer = User.create(
    role: '',
    company: company,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'AIJP123456',
    contact_number: Faker::PhoneNumber.phone_number_with_country_code,
    confirmed_at: DateTime.now
  )

  puts "Creating job_seeker #{i+1}"
  job_seeker = User.create(
    role: 'job_seeker',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'AIJP123456',
    contact_number: Faker::PhoneNumber.phone_number_with_country_code,
    confirmed_at: DateTime.now
  )
end

# sample jobs
User.where(role: 'employer').each_with_index do |employer, i|
  puts "Creating job #{i+1} for #{employer.company.name}"
  Job.create(
    title: Faker::Job.title,
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    job_type: ['Contract', 'Fulltime', 'Part time', 'Internship'].sample,
    job_location: ['Remote', 'Onsite'].sample,
    company_id: employer.company_id,
    posted_by_id: employer.id,
    applicable_for: ['Freshers', 'Intermediate', 'Experienced', 'Expert', 'Open for all'].sample,
    salary_range: ['$1000-$2500', '$2500-$5000', '$5000-$10000', '> $10000', 'Hourly'].sample,
    link_to_apply: "https://#{employer.company.name.downcase.gsub(' ', '')}.org/careers/",
    total_positions: rand(1..5)
  )
end
