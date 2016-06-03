class HistoryRecordsController < ApplicationController
  before_action :set_history_record, only: [:show, :edit, :update, :destroy, :send_data_points]
  respond_to :html, :js

  # GET /history_records
  # GET /history_records.json
  def index
    @history_records = HistoryRecord.all.includes(:historian)
  end

  # GET /history_records/1
  # GET /history_records/1.json
  def show
  end

  # GET /history_records/new
  def new
    @history_record = HistoryRecord.new
  end

  # GET /history_records/1/edit
  def edit
  end

  # POST /history_records
  # POST /history_records.json
  def create
    @history_record = HistoryRecord.new(history_record_params)
    @history_record.send_to_florincoin
    if @history_record.save
      redirect_to @history_record, notice: 'History record was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /history_records/1
  # PATCH/PUT /history_records/1.json
  def update
    if @history_record.update(history_record_params)
      @history_record.update_schedule_status
      redirect_to @history_record, notice: 'History record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /history_records/1
  # DELETE /history_records/1.json
  def destroy
    @history_record.destroy
    redirect_to history_records_url, notice: 'History record was successfully destroyed.'
  end

  ## GET /send_data_points
  ## GET /history_records/1.json
  ### Start and Stop scheduler ##
  def send_data_points
    @history_record.update(history_record_params)
    @history_record.update_schedule_status
    redirect_to history_records_path, notice: "Scheduler #{params[:status]} for scheduled rate."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_record
      @history_record = HistoryRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_record_params
      params.require(:history_record).permit(:title, :http_api_address, :fields_to_store, :rate, :public, :historian_id, :scheduled_date, :schedule_status)
    end
end
