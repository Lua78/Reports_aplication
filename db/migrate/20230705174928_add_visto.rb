class AddVisto < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :visto, :boolean, default: false
    change_column_null :reports, :visto, false
  end
end
