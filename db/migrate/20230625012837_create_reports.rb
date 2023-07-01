class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :user
      t.string :tittle
      t.text :description

      t.timestamps
    end
  end
end
