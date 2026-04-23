require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  let(:valid_attributes) do
    {
      first_name: "Mukesh",
      last_name: "Jha",
      job_title: "Software Engineer",
      country: "India",
      salary: 50000,
      email: "mukesh@example.com"
    }
  end

  before(:each) do
    assign(:employees, [
      Employee.create!(
        first_name: "Mukesh",
        last_name: "Jha",
        job_title: "Software Engineer",
        country: "India",
        salary: 50000,
        email: "mukesh@example.com"
      ),
      Employee.create!(
        first_name: "Rahul",
        last_name: "Singh",
        job_title: "Software Engineer",
        country: "India",
        salary: 65000,
        email: "rahul@gmail.com"
      )
    ])
  end

  it "renders a list of employees" do
    render
    cell_selector = "div>p"
    assert_select cell_selector, text: Regexp.new("Mukesh"), count: 1
    assert_select cell_selector, text: Regexp.new("Rahul"),  count: 1
    assert_select cell_selector, text: Regexp.new("Jha"),    count: 1
    assert_select cell_selector, text: Regexp.new("Software Engineer"), count: 2
    assert_select cell_selector, text: Regexp.new("India"),  count: 2
    assert_select cell_selector, text: Regexp.new("50000"),  count: 1
  end
end
