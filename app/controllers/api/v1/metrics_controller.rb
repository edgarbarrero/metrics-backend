class Api::V1::MetricsController < ApplicationController
  def index
    metrics = MetricsAggregatorService.new(params).call

    render json: metrics
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
