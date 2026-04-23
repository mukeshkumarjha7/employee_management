# Seed script for 10,000 employees
# Idempotent: clears existing data before re-seeding
# Performant: uses insert_all in batches of 1,000 rows

COUNTRIES = ["USA", "UK", "Australia", "India", "Brazil", "Japan", "Singapore"].freeze

JOB_TITLES = [
  "Software Engineer", "Senior Software Engineer", "Staff Engineer",
  "Engineering Manager", "Product Manager", "Data Scientist","Technical Lead"
].freeze

SALARY_RANGES = {
  "Software Engineer"        => (40_000..70_000),
  "Senior Software Engineer" => (60_000..90_000),
  "Staff Engineer"           => (70_000..120000),
  "Engineering Manager"      => (70_000..190_000),
  "Product Manager"          => (60_000..120_000),
  "Data Scientist"           => (50_000..80_000),
  "Data Analyst"             => (65_000..100_000),
  "Technical Lead"           => (70_000..120000)
}.freeze

TOTAL = 2500
BATCH = 100

puts "Remove existing employees..."
Employee.delete_all

first_names = File.readlines(Rails.root.join("db/first_names.txt"), chomp: true).reject(&:empty?)
last_names  = File.readlines(Rails.root.join("db/last_names.txt"),  chomp: true).reject(&:empty?)

puts "Seeding #{TOTAL} employees"

now         = Time.current
inserted    = 0
email_index = 0

TOTAL.times.each_slice(BATCH) do |batch_indices|
  records = batch_indices.map do
    first_name = first_names.sample
    last_name  = last_names.sample
    job_title  = JOB_TITLES.sample
    country    = COUNTRIES.sample
    range      = SALARY_RANGES[job_title]
    salary     = rand(range)
    doj        = rand(365*5).days.ago.to_date  
    email_index += 1

    {
      first_name:      first_name,
      last_name:       last_name,
      email:           "#{first_name.downcase}.#{last_name.downcase}#{email_index}@example.com",
      job_title:       job_title,
      country:         country,
      salary:          salary,
      date_of_joining: doj,
      created_at:      now,
      updated_at:      now
    }
  end

  Employee.insert_all(records)
  inserted += records.size
  puts "  Inserted #{inserted}/#{TOTAL}"
end

puts "\nDone. #{Employee.count} employees in database."
