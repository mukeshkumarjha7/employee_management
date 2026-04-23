class AddIndexesToEmployees < ActiveRecord::Migration[8.1]
  def change

    add_index :employees, :email, unique: true
    add_index :employees, [ :first_name, :last_name ]
    add_index :employees, [ :country, :job_title ]
  end
end
