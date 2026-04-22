class EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :update, :destroy ]

  def index
    @employees = Employee.all
    render json: @employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  def search
    if params[:name].blank? && params[:country].blank? && params[:job_title].blank?
      return render json: { error: "At least one search parameter (name, country, job_title) is required" }, status: :bad_request
    end

    employees = nil
    if params[:name].present?
      employees = Employee.by_name(params[:name])
    elsif params[:country].present?
      employees = Employee.by_country(params[:country])
    elsif params[:job_title].present?
      employees = Employee.by_job_title(params[:job_title])
    else
      render json: { errors: "Search parameter is empty" }, status: :bad_request
    end

    render json: employees, status: :ok
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary, :email, :date_of_joining)
  end
end
