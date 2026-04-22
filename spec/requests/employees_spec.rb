require 'rails_helper'

RSpec.describe "Employees", type: :request do
  let(:valid_attributes) do
    {
      full_name: "Mukesh Jha",
      job_title: "Software Engineer",
      country: "India",
      salary: 50000,
      email: "mukesh_jha@gmail.com"
    }
  end

  # GET /employees
  it "returns a list of employees" do
    get employees_path
    expect(response).to have_http_status(:ok)
  end

  # GET /employees/:id
  it "returns a single employee" do
    employee = Employee.create!(valid_attributes)

    get employee_path(employee)
    expect(response).to have_http_status(:ok)
  end

  # POST /employees
  it "creates a new employee" do
    post employees_path, params: { employee: valid_attributes }
    expect(response).to have_http_status(:created)
  end

  it "does not create an employee for invalid attributes" do
    post employees_path, params: { employee: valid_attributes.merge(full_name: nil) }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  # PATCH /employees/:id
  it "update existing employee" do
    employee = Employee.create!(valid_attributes)
    patch employee_path(employee), params: { employee: { full_name: "Jha Mukesh" } }
    expect(response).to have_http_status(:ok)
  end

  it "does not update an employee with invalid attributes" do
    employee = Employee.create!(valid_attributes)
    patch employee_path(employee), params: { employee: { salary: -1 } }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  # DELETE /employees/:id
  it "deletes an employee" do
    employee = Employee.create!(valid_attributes)
    delete employee_path(employee)
    expect(response).to have_http_status(:no_content)
  end


  # Add test cases for search

  # GET /employees/search?name=
  it "returns employees matching the given name" do
    Employee.create!(valid_attributes)
    get search_employees_path, params: { name: "Mukesh Jha" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).map { |e| e["full_name"] }).to include("Mukesh Jha")
  end

  it "returns empty array when no employee matches the name" do
    get search_employees_path, params: { name: "Invalid Name" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to be_empty
  end

  # GET /employees/search?country=
  it "returns employees from the given country" do
    Employee.create!(valid_attributes)
    get search_employees_path, params: { country: "India" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).map { |e| e["country"] }).to all(eq("India"))
  end

  it "returns empty array when no employee is from the given country" do
    get search_employees_path, params: { country: "US" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to be_empty
  end

  # GET /employees/search?job_title=
  it "returns employees with the given job title" do
    Employee.create!(valid_attributes)
    get search_employees_path, params: { job_title: "Software Engineer" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).map { |e| e["job_title"] }).to all(eq("Software Engineer"))
  end

  it "returns empty array when no employee has the given job title" do
    get search_employees_path, params: { job_title: "Accountant" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to be_empty
  end

  # GET /employees/search
  it "returns bad request when search doesn't have params" do
    get search_employees_path
    expect(response).to have_http_status(:bad_request)
  end

  it "returns bad request when all params are blank for search" do
    get search_employees_path, params: { name: "", country: "", job_title: "" }
    expect(response).to have_http_status(:bad_request)
  end
end
