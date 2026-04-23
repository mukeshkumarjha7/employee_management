require 'rails_helper'

RSpec.describe "employees/edit", type: :view do
  let(:employee) do
    Employee.create!(
      first_name: "Mukesh",
      last_name: "Jha",
      job_title: "Software Engineer",
      country: "India",
      salary: 50000,
      email: "mukesh@example.com"
    )
  end

  before(:each) do
    assign(:employee, employee)
  end

  it "renders the edit employee form" do
    render
    assert_select "form[action=?][method=?]", employee_path(employee), "post" do
      assert_select "input[name=?]", "employee[first_name]"
      assert_select "input[name=?]", "employee[last_name]"
      assert_select "input[name=?]", "employee[job_title]"
      assert_select "input[name=?]", "employee[country]"
      assert_select "input[name=?]", "employee[salary]"
      assert_select "input[name=?]", "employee[email]"
    end
  end
end
