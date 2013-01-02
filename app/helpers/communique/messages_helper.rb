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

    def add_comma_padding!(str) # TODO: make the separator configurable by user
      str.gsub!(/,/, ', ')
    end

    def delete_link(path)
      link_to I18n.t('messages.actions.delete'), path, :method => :post
    end

    
    def trash_link(path)
      link_to I18n.t('messages.actions.trash'), path, :method => :post
    end

    def restore_link(path)
      link_to I18n.t('messages.actions.restore'), path, :method => :post
    end
  end
end
