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

    def is_received_message?(message)
      message.respond_to?(:message_id)
    end

    def generate_destroy_link(message, message_type=nil)
      path = message_type.nil? ? "_path" : "_#{message_type}_path"
      link_to I18n.t('messages.actions.delete'), eval("destroy#{path}(message)")
    end

    def generate_reply_link(message)
      return unless is_received_message?(message)
      link_to I18n.t('messages.actions.reply'), reply_path(message.message)
    end

  end
end
