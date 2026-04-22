class Employee < ApplicationRecord
    validates :full_name, :job_title, :country, :email, presence: true

    validates :salary, presence: true, numericality: { greater_than: 0 }

    validates :email, uniqueness: true
end
