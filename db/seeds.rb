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
    contact: Faker::PhoneNumber.phone_number_with_country_code
  )

  puts "Creating employeer #{i+1}"
  employeer = User.create(
    role: 'employeer',
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
User.where(role: 'employeer').each_with_index do |employeer, i|
  puts "Creating job #{i+1} for #{employeer.company.name}"
  Job.create(
    title: Faker::Job.title,
    description: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
    job_type: ['Contract', 'Fulltime', 'Part time', 'Internship'].sample,
    job_location: ['Remote', 'Onsite'].sample,
    company_id: employeer.company_id,
    posted_by_id: employeer.id,
    applicable_for: ['Freshers', 'Intermediate', 'Experienced', 'Expert', 'Open for all'].sample,
    salary_range: ['$1000-$2500', '$2500-$5000', '$5000-$10000', '> $10000', 'Hourly'].sample,
    link_to_apply: "https://#{employeer.company.name.downcase.gsub(' ', '')}.org/careers/",
    total_positions: rand(1..5)
  )
end
