class SalaryInsightsService
  def initialize(country, job_title: nil)
    @scope = Employee.by_country(country)
    if job_title.present?
      @scope = @scope.by_job_title(job_title)
    end
  end

  def call
    result = @scope.pick(
      Arel.sql("COUNT(*), MIN(salary), MAX(salary), AVG(salary)")
    )

    count = result[0].to_i
    return { employees_count: 0, min_salary: nil, max_salary: nil, avg_salary: nil } if count.zero?

    {
      employees_count: count,
      min_salary:      result[1].to_f,
      max_salary:      result[2].to_f,
      avg_salary:      result[3].to_f
    }
  end
end
