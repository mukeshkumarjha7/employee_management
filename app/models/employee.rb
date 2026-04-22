class Employee < ApplicationRecord
    validates :full_name, :job_title, :country, :email, presence: true
    validates :salary, presence: true, numericality: { greater_than: 0 }
    validates :email, uniqueness: true

    scope :by_name, ->(name) { where(full_name: name) }
    scope :by_country, ->(country) { where(country: country) }
    scope :by_job_title, ->(job_title) { where(job_title: job_title) }
end
