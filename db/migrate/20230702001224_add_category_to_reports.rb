class AddCategoryToReports < ActiveRecord::Migration[7.0]
  def change
    add_reference :reports, :category, null: false, foreign_key: true
  end
end
