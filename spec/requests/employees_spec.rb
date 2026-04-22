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
end
