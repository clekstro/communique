module Communique
  module MessagesHelper

    def time_if_today(input_date)
      dt = input_date.to_datetime
      input_date.day == DateTime.now.day ? format_time(dt) : format_date(dt)
    end

    def format_time(input_date)
      I18n.localize(input_date, format: :shortened_time)
    end

    def format_date(input_date)
      I18n.localize(input_date, format: :shortened_day)
    end

    def add_comma_padding!(str) # TODO: make the separator configurable by userblock_if_sent
      str.gsub!(/,/, ', ')
    end

  end
end
