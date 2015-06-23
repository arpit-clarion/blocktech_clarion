class HrDataPointsController < ApplicationController
  before_action :set_hr_data_point, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /hr_data_points
  # GET /hr_data_points.json
  def index
    @hr_data_points = HrDataPoint.all
  end

  # GET /hr_data_points/1
  # GET /hr_data_points/1.json
  def show
  end

  # GET /hr_data_points/new
  def new
    @hr_data_point = HrDataPoint.new
  end

  # GET /hr_data_points/1/edit
  def edit
  end

  # POST /hr_data_points
  # POST /hr_data_points.json
  def create
    @hr_data_point = HrDataPoint.new(hr_data_point_params)
    if @hr_data_point.save
      redirect_to @hr_data_point, notice: 'Hr data point was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /hr_data_points/1
  # PATCH/PUT /hr_data_points/1.json
  def update
    if @hr_data_point.update(hr_data_point_params)
      redirect_to @hr_data_point, notice: 'Hr data point was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /hr_data_points/1
  # DELETE /hr_data_points/1.json
  def destroy
    @hr_data_point.destroy
    redirect_to hr_data_points_url, notice: 'Hr data point was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hr_data_point
      @hr_data_point = HrDataPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hr_data_point_params
      params.require(:hr_data_point).permit(:txn_id, :history_record_id, :data_points)
    end
end
