class AddValidations < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reports, :user, false 
    change_column_null :reports, :tittle, false 
    change_column_null :reports, :description, false 
  end
end
