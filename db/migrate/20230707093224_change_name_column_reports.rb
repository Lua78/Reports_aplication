class ChangeNameColumnReports < ActiveRecord::Migration[7.0]
  def change
    rename_column :reports, :user, :nameuser
  end
end
