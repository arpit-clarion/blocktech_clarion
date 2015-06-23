class HrDataPoint < ActiveRecord::Base
  ### Associations ###
  belongs_to :history_record
  ###

  # serialize field is for data points on the header for history records
  serialize :data_points, Hash

end
