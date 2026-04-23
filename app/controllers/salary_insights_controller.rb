class SalaryInsightsController < ApplicationController
  def index
    if params[:country].blank?
      respond_to do |format|
        format.html { render :index }
        format.json { render json: { error: "country name is required" }, status: :bad_request }
      end
      return
    end

    @country   = params[:country]
    @job_title = params[:job_title]
    @insights  = SalaryInsightsService.new(@country, job_title: @job_title).call

    respond_to do |format|
      format.html
      format.json { render json: @insights, status: :ok }
    end
  end
end
