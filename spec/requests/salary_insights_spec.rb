require 'rails_helper'

RSpec.describe "SalaryInsights", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/salary_insights/index"
      expect(response).to have_http_status(:success)
    end
  end

end
