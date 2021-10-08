require 'rails_helper'

RSpec.describe Api::V1::MetricsController do
  describe "GET #index" do
    let!(:metric_day_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 00:00'))  }

    it "returns http success and JSON body response contains expected metrics" do
      %w(day hour minute).each do |group_by|
        get :index, params: { group_by: group_by, format: :json}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response).to eq({"2021-10-07 00:00"=>"10.0"})
      end
    end

    it "returns an error response if no params given" do
      expect { get :index }.to raise_exception
    end
  end

  describe "POST #create" do
    it "returns http success and JSON body response contains expected metrics" do
      post :create, params: { name: 'user_metric', value: 10, timestamp: Time.zone.parse('2021-10-7 00:00') }
      expect(response).to have_http_status(:success)
    end
  end
end
