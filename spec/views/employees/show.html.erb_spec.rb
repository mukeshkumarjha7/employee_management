require 'rails_helper'

RSpec.describe "employees/show", type: :view do
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

  it "renders employee attributes" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Mukesh")
    assert_select cell_selector, text: Regexp.new("Jha")
    assert_select cell_selector, text: Regexp.new("Software Engineer")
    assert_select cell_selector, text: Regexp.new("India")
    assert_select cell_selector, text: Regexp.new("50000")
    assert_select cell_selector, text: Regexp.new("mukesh@example.com")
  end
end
