class SalaryInsightsController < ApplicationController
  def index
    if params[:country].blank?
      return render json: { error: "country name is required" }, status: :bad_request
    end

    insights = SalaryInsightsService.new(params[:country], job_title: params[:job_title]).call
    render json: insights, status: :ok
  end
end
