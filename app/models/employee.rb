class Employee < ApplicationRecord
    validates :first_name, :last_name, :job_title, :country, :email, presence: true
    validates :salary, presence: true, numericality: { greater_than: 0 }
    validates :email, uniqueness: true

    scope :by_name, ->(first_name, last_name) { where(first_name: first_name, last_name: last_name) }
    scope :by_first_name, ->(first_name) { where(first_name: first_name) }
    scope :by_country, ->(country) { where(country: country) }
    scope :by_job_title, ->(job_title) { where(job_title: job_title) }
end
