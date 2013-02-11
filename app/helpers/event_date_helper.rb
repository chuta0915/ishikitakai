module EventDateHelper
  def event_date_formatted(begin_at, end_at)
    begin_date = begin_at.strftime(t('date.short'))
    begin_time = begin_at.strftime(t('time.short'))
    end_date = end_at.strftime(t('date.short'))
    end_time = end_at.strftime(t('time.short'))
    
    params = {
      begin_date: begin_date,
      begin_time: begin_time,
      end_date: end_date,
      end_time: end_time,
    }

    if begin_date == end_date
      t('date.span_1day', params)
    else
      t('date.span_days', params)
    end
  end
end
