class Api::V1::MetricsController < ApplicationController
  def index
    @metrics = MetricsAggregatorService.new(params).call
    if @metrics.blank?
      render json: { error: 500 }, status: 500
    else
      render json: @metrics
    end
  end

  def create
    metric = Metric.new(metric_params)
    if metric.save
      render json: { success: 200 }, status: 200
    else
      render json: { error: 500 }, status: 500
    end
  end

  private

  def metric_params
    params.permit(:name, :value, :timestamp)
  end
end
