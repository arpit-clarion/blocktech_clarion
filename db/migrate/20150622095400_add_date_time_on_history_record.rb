class AddDateTimeOnHistoryRecord < ActiveRecord::Migration
  def change
    add_column :history_records , :scheduled_date, :datetime
    add_column :history_records , :schedule_status, :boolean
  end
end
