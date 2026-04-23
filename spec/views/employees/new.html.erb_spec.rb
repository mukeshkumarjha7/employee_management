require 'rails_helper'

RSpec.describe "employees/new", type: :view do
  before(:each) do
    assign(:employee, Employee.new)
  end

  it "renders the new employee form" do
    render
    assert_select "form[action=?][method=?]", employees_path, "post" do
      assert_select "input[name=?]", "employee[first_name]"
      assert_select "input[name=?]", "employee[last_name]"
      assert_select "input[name=?]", "employee[job_title]"
      assert_select "input[name=?]", "employee[country]"
      assert_select "input[name=?]", "employee[salary]"
      assert_select "input[name=?]", "employee[email]"
    end
  end
end
