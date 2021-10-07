require 'rails_helper'

RSpec.describe MetricsAggregatorService, type: :model do
  describe '#call' do
    let(:metric_day_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 00:00'))  }
    let(:metric_day_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2021-10-7 03:45'))  }
    let(:metric_day_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-9 00:00'))  }

    let(:metric_hour_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 00:00'))  }
    let(:metric_hour_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2021-10-7 00:15'))  }
    let(:metric_hour_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 02:00'))  }

    let(:metric_minute_1) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 00:00'))  }
    let(:metric_minute_2) { create(:metric, value: 5, timestamp: Time.zone.parse('2021-10-7 00:02'))  }
    let(:metric_minute_3) { create(:metric, value: 10, timestamp: Time.zone.parse('2021-10-7 00:02'))  }

    let(:gruop_by_day_params) { { group_by: 'day'} }
    let(:gruop_by_hour_params) { { group_by: 'hour'} }
    let(:gruop_by_minute_params) { { group_by: 'minute'} }

    it "works grouping by days" do
      metric_day_1
      metric_day_2
      metric_day_3

      hsh = described_class.new(gruop_by_day_params).call
      expect(hsh).to eq({"2021-10-07 00:00"=>0.75e1, "2021-10-08 00:00"=>0, "2021-10-09 00:00"=>0.1e2})
    end

    it "works grouping by hours" do
      metric_hour_1
      metric_hour_2
      metric_hour_3

      hsh = described_class.new(gruop_by_hour_params).call
      expect(hsh).to eq({"2021-10-07 00:00"=>0.75e1, "2021-10-07 01:00"=>0, "2021-10-07 02:00"=>0.1e2})
    end

    it "works grouping by hours" do
      metric_minute_1
      metric_minute_2
      metric_minute_3

      hsh = described_class.new(gruop_by_minute_params).call
      expect(hsh).to eq({"2021-10-07 00:00"=>0.1e2, "2021-10-07 00:01"=>0, "2021-10-07 00:02"=>0.75e1})
    end
  end
end
