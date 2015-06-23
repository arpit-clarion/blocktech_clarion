class CreateHrDataPoints < ActiveRecord::Migration
  def change
    create_table :hr_data_points do |t|
      t.string :txn_id
      t.integer :history_record_id
      t.text :data_points

      t.timestamps null: false
    end
  end
end
