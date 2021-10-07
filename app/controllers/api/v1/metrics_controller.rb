class Api::V1::MetricsController < ApplicationController
  def index
    @metrics = MetricsAggregatorService.new(params).call
    if @metrics.blank?
      render json: { error: 500 }, status: 500
    else
      render json: @metrics
    end
  end
end
