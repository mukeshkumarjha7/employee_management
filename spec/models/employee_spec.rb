require 'rails_helper'                 
                                       
RSpec.describe Employee, type: :model do                                                                                                                                      
  subject do                          
    Employee.new(                     
      full_name: "Mukesh Jha",        
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
                                      
  it "is invalid without full_name" do
    subject.full_name = nil           
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
                                      
  it "is invalid without salary" do   
    subject.salary = nil              
    expect(subject).not_to be_valid   
  end                                 
                                      
  # Salary validation                 
  it "is invalid if salary is <= 0" do
    subject.salary = 0                
    expect(subject).not_to be_valid   
  end                                 
                                      
  # Email validation                  
  it "is invalid without email" do    
    subject.email = nil               
    expect(subject).not_to be_valid   
  end

  it "is invalid for duplicate email" do
    Employee.create!(subject.attributes)
    new_record = Employee.new(subject.attributes)
    expect(new_record).not_to be_valid
  end
#
  it "return employee for given name" do
    employee = Employee.create!(subject.attributes)
    record = Employee.find_by_name("Mukesh Jha")
    expect(record).to include(employee)
  end

  it "return empty if employee doesn't exist" do
    record = Employee.by_name("Invalid User")
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