require 'rails_helper'

RSpec.describe "salary_insights/index", type: :view do
  let(:cell_selector) { "div>p" }

  before(:each) do
    assign(:country, "India")
    assign(:job_title, nil)
    assign(:insights, {
      employees_count: 3,
      min_salary:      50000.0,
      max_salary:      80000.0,
      avg_salary:      65000.0
    })
  end

  it "renders the search form" do
    render
    assert_select "form" do
      assert_select "input[name=?]", "country"
      assert_select "input[name=?]", "job_title"
      assert_select "input[type=?]", "submit"
    end
  end

  it "renders salary insights for a country" do
    render
    assert_select "h2 span", text: Regexp.new("India")
    assert_select cell_selector, text: Regexp.new("50000")
    assert_select cell_selector, text: Regexp.new("80000")
    assert_select cell_selector, text: Regexp.new("65000")
    assert_select cell_selector, text: Regexp.new("3")
  end

  it "renders average salary" do
    assign(:job_title, "Software Engineer")
    assign(:insights, {
      employees_count: 2,
      min_salary:      50000.0,
      max_salary:      65000.0,
      avg_salary:      57500.0
    })
    render
    assert_select "h2 span", text: Regexp.new("Software Engineer")
    assert_select cell_selector, text: Regexp.new("57500")
  end

  it "renders 0 employees when count is zero" do
    assign(:insights, {
      employees_count: 0,
      min_salary:      nil,
      max_salary:      nil,
      avg_salary:      nil
    })
    render
    assert_select cell_selector, text: Regexp.new("No employees found")
  end
end
