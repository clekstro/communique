module Communique
  module MessagesHelper
    def time_if_today(input_date)
      dt = input_date.to_datetime
      if input_date.day == DateTime.now.day
        format_time(input_date)
      else
        format_date(input_date)
      end
    end
    def format_time(input_date)
      I18n.localize(input_date, format: :shortened_time)
    end
    def format_date(input_date)
      I18n.localize(input_date, format: :shortened_day)
    end

  end
end
