class SalaryInsightsService
  def initialize(country, job_title: nil)
    @scope = Employee.by_country(country)
    if job_title.present?
      @scope = @scope.by_job_title(job_title)
    end
  end

  def call
    count = @scope.count
    if count.zero?
      return { employees_count: 0, min_salary: nil, max_salary: nil, avg_salary: nil }
    end

    {
      employees_count: count,
      min_salary:      @scope.minimum(:salary).to_f,
      max_salary:      @scope.maximum(:salary).to_f,
      avg_salary:      @scope.average(:salary).to_f
    }
  end
end
