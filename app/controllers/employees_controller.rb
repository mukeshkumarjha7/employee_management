class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = Employee.order(Arel.sql("date_of_joining DESC NULLS LAST"))
                         .page(params[:page] || 1)
                         .per(params[:per_page] || 10)
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html { redirect_to employees_path, notice: "Employee was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /employees/search
  def search
    if params[:first_name].blank? && params[:last_name].blank? && params[:country].blank? && params[:job_title].blank?
      return render json: { error: "At least one search parameter (first_name, last_name, country, job_title) is required" }, status: :bad_request
    end

    employees = Employee.all
    if params[:first_name].present? && params[:last_name].present?
      employees = employees.by_name(params[:first_name], params[:last_name])
    elsif params[:first_name].present?
      employees = employees.by_first_name(params[:first_name])
    end

    employees = employees.by_country(params[:country]) if params[:country].present? 
    employees = employees.by_job_title(params[:job_title]) if params[:job_title].present?

    render json: employees, status: :ok
  end


  private

    def set_employee
      @employee = Employee.find(params.expect(:id))
    end

    def employee_params
      params.expect(employee: [ :first_name, :last_name, :job_title, :country, :salary, :email, :date_of_joining ])
    end
end
