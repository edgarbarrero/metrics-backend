class Metric < ApplicationRecord
  SQL_MINUTE_DATE_FORMAT = "%Y-%m-%d %H:%i"
  SQL_HOUR_DATE_FORMAT = "%Y-%m-%d %H:00"
  SQL_DAY_DATE_FORMAT = "%Y-%m-%d 00:00"

  def self.aggregated_by(group_by)
    self.group("date_format(timestamp, '#{const_get "SQL_#{group_by}_DATE_FORMAT"}')")
        .average(:value)
  end
end
