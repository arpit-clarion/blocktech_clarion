json.array!(@hr_data_points) do |hr_data_point|
  json.extract! hr_data_point, :id, :txn_id, :history_record_id, :data_points
  json.url hr_data_point_url(hr_data_point, format: :json)
end
