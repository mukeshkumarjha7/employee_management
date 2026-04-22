require 'rails_helper'

RSpec.describe "SalaryInsights", type: :request do
  let!(:employee1) do
    Employee.create!(
      first_name: "Mukesh",
      last_name: "Jha",
      job_title: "Software Engineer",
      country: "India",
      salary: 50000,
      email: "mukesh@gmail.com"
    )
  end

  let!(:employee2) do
    Employee.create!(
      first_name: "Rahul",
      last_name: "Singh",
      job_title: "Software Engineer",
      country: "India",
      salary: 65000,
      email: "rahul@gmail.com"
    )
  end

  let!(:employee3) do
    Employee.create!(
      first_name: "Priya",
      last_name: "Patel",
      job_title: "Product Manager",
      country: "India",
      salary: 80000,
      email: "priya@gmail.com"
    )
  end

  let!(:employee4) do
    Employee.create!(
      first_name: "John",
      last_name: "Smith",
      job_title: "Software Engineer",
      country: "USA",
      salary: 120000,
      email: "john@gmail.com"
    )
  end

  # Country param is not available.
  it "returns bad request when country is not provided" do
    get salary_insights_path
    expect(response).to have_http_status(:bad_request)
  end

  # Min, max, avg salary for a country
  it "returns min salary for a country" do
    get salary_insights_path, params: { country: "India" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["min_salary"]).to eq(50000)
  end

  it "returns max salary for a country" do
    get salary_insights_path, params: { country: "India" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["max_salary"]).to eq(80000)
  end

  it "returns average salary for a country" do
    get salary_insights_path, params: { country: "India" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["avg_salary"]).to eq(65000)
  end

  # Avg salary for a job title in a country
  it "returns average salary for a given job title in a country" do
    get salary_insights_path, params: { country: "India", job_title: "Software Engineer" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["avg_salary"]).to eq(57500)
  end

  # Total employee
  it "returns total employee count for a country" do
    get salary_insights_path, params: { country: "India" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["employees_count"]).to eq(3)
  end

  # Country not found
  it "returns empty insights for a country with no employees" do
    get salary_insights_path, params: { country: "UK" }
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body["employees_count"]).to eq(0)
    expect(body["min_salary"]).to be_nil
    expect(body["max_salary"]).to be_nil
    expect(body["avg_salary"]).to be_nil
  end

end
