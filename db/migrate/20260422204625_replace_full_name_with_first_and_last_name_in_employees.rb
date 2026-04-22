class ReplaceFullNameWithFirstAndLastNameInEmployees < ActiveRecord::Migration[8.1]
  def change
    remove_column :employees, :full_name, :string
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
  end
end
