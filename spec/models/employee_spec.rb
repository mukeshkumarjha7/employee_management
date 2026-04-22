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
end  