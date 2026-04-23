require 'rails_helper'                 
                                       
RSpec.describe Employee, type: :model do                                                                                                                                      
  subject do
    Employee.new(
      first_name: "Mukesh",
      last_name: "Jha",
      job_title: "Software Engineer",
      country: "India",
      salary: 50000,
      email: "mukesh_jha@gmail.com"
    )
  end

  # Presence validations
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without first_name" do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid when first_name contains numbers" do
    subject.first_name = "Mukesh123"
    expect(subject).not_to be_valid
  end

  it "is invalid when first_name contains special characters" do
    subject.first_name = "Muk@sh!"
    expect(subject).not_to be_valid
  end

  it "is invalid without last_name" do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if last_name contains numbers" do
    subject.last_name = "Jha123"
    expect(subject).not_to be_valid
  end

  it "is invalid if last_name contains special characters" do
    subject.last_name = "Jha@#"
    expect(subject).not_to be_valid
  end                                 
                                      
  it "is invalid without job_title" do
    subject.job_title = nil           
    expect(subject).not_to be_valid   
  end                                 
                                      
  it "is invalid without country" do
    subject.country = nil
    expect(subject).not_to be_valid
  end

  it "is invalid if country contains numbers" do
    subject.country = "India123"
    expect(subject).not_to be_valid
  end

  it "is invalid if country contains special characters" do
    subject.country = "Ind@a!"
    expect(subject).not_to be_valid
  end

  it "is invalid without salary" do
    subject.salary = nil
    expect(subject).not_to be_valid
  end

  # Salary validation
  it "is invalid if salary is <= 0" do
    subject.salary = 0
    expect(subject).not_to be_valid
  end

  it "is invalid if salary is not a number" do
    subject.salary = "fifty thousand"
    expect(subject).not_to be_valid
  end

  # Date of joining validation
  it "is invalid if date_of_joining is in the future" do
    subject.date_of_joining = Date.today + 1
    expect(subject).not_to be_valid
  end

  it "is valid if date_of_joining is in the past" do
    subject.date_of_joining = Date.today - 30
    expect(subject).to be_valid
  end                                 
                                      
  # Email validation
  it "is invalid without email" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "is invalid with missing @ in email" do
    subject.email = "mukeshjhagmail.com"
    expect(subject).not_to be_valid
  end

  it "is invalid if domain is missing in email" do
    subject.email = "mukeshjha@"
    expect(subject).not_to be_valid
  end

  it "is invalid is username part is missing in email" do
    subject.email = "@gmail.com"
    expect(subject).not_to be_valid
  end

  it "is invalid if domain in invalid" do
    subject.email = "mukeshjha@gmail"
    expect(subject).not_to be_valid
  end

  it "is valid for a proper format email" do
    subject.email = "mukesh.jha@company.com"
    expect(subject).to be_valid
  end

  it "is invalid for duplicate email" do
    Employee.create!(subject.attributes)
    new_record = Employee.new(subject.attributes)
    expect(new_record).not_to be_valid
  end

  it "returns employee for given first and last name" do
    employee = Employee.create!(subject.attributes)
    record = Employee.by_name("Mukesh", "Jha")
    expect(record).to include(employee)
  end

  it "returns empty if no employee matches first and last name" do
    record = Employee.by_name("Invalid", "User")
    expect(record).to be_empty
  end

  it "returns employee for given first name only" do
    employee = Employee.create!(subject.attributes)
    record = Employee.by_first_name("Mukesh")
    expect(record).to include(employee)
  end

  it "returns empty if no employee matches first name" do
    record = Employee.by_first_name("Unknown")
    expect(record).to be_empty
  end

  it "return employee list for given country" do
    employee = Employee.create!(subject.attributes)
    record = Employee.by_country("India")
    expect(record).to include(employee)
  end

  it "return empty if no employee belongs to given country" do
    record = Employee.by_country("US")
    expect(record).to be_empty
  end

  it "return employee list of given title" do
    employee = Employee.create!(subject.attributes)
    record = Employee.by_job_title("Software Engineer")
    expect(record).to include(employee)
  end

  it "return empty if no employee has the given job title" do
    record = Employee.by_job_title("HR")
    expect(record).to be_empty
  end
end  