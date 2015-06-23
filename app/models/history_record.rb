class HistoryRecord < ActiveRecord::Base

  ### Constants ###
  RATES = { '5m' => '5 Minutes', '10m' => '10 Minutes', '15m' => '15 Minutes', '30m'=> '30 Minutes', '1h'=> '1 Hour' }
  ####

  ### Associations ###
  belongs_to :historian
  has_many :hr_data_points
  #####

  ### Validations ###
  validates :title, :http_api_address, :fields_to_store, :rate, :public, presence: true
  validates :txn_id, uniqueness: true ,allow_blank: true
  ####

  # serialize field is for data points on the header for history records
  serialize :data_points, Hash

  #Object Methods, Initialize Rpc calls and send transition with tx-comment
  def send_to_florincoin(send_dp=nil)
    historian = Historian.where(id: historian_id).first
    if historian.present?
      florincoin_client = FlorincoinRPC.new()
      signature = florincoin_client.signmessage(historian.address, "#{title}-#{historian.address}-#{Time.now.to_i}")
      if send_dp.nil?
        tx_comment = get_hr_tx_comment(historian, signature)
        self.txn_id = send_message(florincoin_client, historian, tx_comment)
      else
        tx_comment = get_hr_data_point_tx_comment(historian, signature)
        data_point_txn_id = send_message(florincoin_client, historian, tx_comment)
        self.save_data_fields(data_point_txn_id)
      end
    end
    errors.add(:txn_id, 'Transaction is not generated.') if self.txn_id.blank?
  end

  def send_message(florincoin_client, historian, tx_comment)
    florincoin_client.sendtoaddress(historian.address, 0.01, "", "", tx_comment)
  end

  # This method will generate Transaction comment for new historian records
  def get_hr_tx_comment(historian, signature)
    { "alexandria-history-record" => {  "title" => "#{title}",
                                      "address" => "#{historian.address}",
                                      "timestamp" => "#{Time.now.to_i}",
                                      "api" => "#{http_api_address}",
                                      "fields"=> "#{fields_to_store}",
                                      "rate" => "#{rate}"
                                      },
      "signature"=> "#{signature}"
    }.to_json
  end

  # This method will generate Transaction comment for history records data points
  def get_hr_data_point_tx_comment(historian, signature)
    datapint_hash = self.data_points.except("timestamp")
    { "alexandria-history-record-datapoint"=> { "title" => "#{title}",
              "address" => "#{historian.address}",
              "timestamp" => "#{Time.now.to_i}",
              "api" => "#{http_api_address}",
            }.merge(datapint_hash),
        "signature"=> "#{signature}"
    }.to_json
  end

  # This will find all the schedueled hisrory records and run RPC accordingly
  def self.call_schedueled_rpc
    schedules = self.where(schedule_status: true).where(scheduled_date: Time.now..Time.now - 5.minutes)
    puts "schedules #{schedules.inspect}"
  end

  # If Schedule status is false Means schedual will be stoped and date will be removed
  # If Schedule status is true that means it will keep on updating date from cron job
  def update_schedule_status
    ### if job is present unschedule it and create new job ###
    jobs = $scheduler.jobs(:tag => self.id)
    $scheduler.unschedule(jobs.first.id) if jobs.present?
    ### schedule job wehn schedule status is true ###
    if schedule_status
      $scheduler.every rate, :tags => "#{self.id}" do
        self.send_to_florincoin(true)
      end
    end
  end

  ### Save data points inside HrDataPoints ###
  def save_data_fields(txn_id=nil)
    data_fields = FlorincoinRPC.new(self.http_api_address)
    data_points = data_fields.get_data
    self.hr_data_points.create(data_points: data_points, txn_id: txn_id)
  end
end


