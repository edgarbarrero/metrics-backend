class MetricsAggregatorService
  GROUPS = %w(minute hour day)
  SQL_MINUTE_DATE_FORMAT = "%Y-%m-%d %H:%i"
  SQL_HOUR_DATE_FORMAT = "%Y-%m-%d %H:00"
  SQL_DAY_DATE_FORMAT = "%Y-%m-%d 00:00"

  MINUTE_DATE_FORMAT = "%Y-%m-%d %H:%M"
  HOUR_DATE_FORMAT = "%Y-%m-%d %H:00"
  DAY_DATE_FORMAT = "%Y-%m-%d 00:00"

  def initialize(params)
    raise unless GROUPS.include? params[:group_by]

    @group_by = params[:group_by].upcase
    @sql_date_format = self.class.const_get "SQL_#{@group_by}_DATE_FORMAT"
    @date_format = self.class.const_get "#{@group_by}_DATE_FORMAT"
    @time_step = time_step
  end

  def call
    empty_hash.merge(metrics_hash)
  end

  private

  def metrics_hash
    Metric.group("date_format(timestamp, '#{@sql_date_format}')").average(:value)
  end

  def empty_hash
    hsh = {}
    start_time = Metric.order(:timestamp).first.timestamp.to_f
    end_time = Metric.order(:timestamp).last.timestamp.to_f

    while start_time <= end_time
      formated_time = Time.at(start_time).utc.strftime(@date_format)
      hsh[formated_time] = 0
      start_time += @time_step
    end
    hsh
  end


  def time_step
    case @group_by
    when 'DAY'
      60*60*24
    when 'HOUR'
      60*60
    when 'MINUTE'
      60
    end
  end
end
