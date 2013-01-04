module Communique
  module Messages
    class InboxController < ApplicationController

      def index
        # messages scoped to current user for security
        @messages = Communique::IncomingMessage.includes(:message => :sender).for(current_user).present
      end

      def show
        @message = find_recipient_message
        redirect_to :messages_inbox_index and return unless @message
        @message.mark_as_read
      end

      def reply
        original_message = Communique::SentMessage.find_by_id(params[:id])
        if original_message && may_reply_to(original_message)
          @message = Communique::ReplyMessage.new(original_message)
          render template: 'communique/messages/drafts/new'
        else
          redirect_to :messages_inbox_index
        end
      end

      def trash
        @message = find_recipient_message
        redirect_to :messages_inbox_index and return unless @message
        @message.mark_as_trashed
      end

      private

      # prevent anyone but recipient from viewing, replying to, trashing or deleting message
      def find_recipient_message
        Communique::IncomingMessage.for(current_user).find_by_id(params[:id])
      end

      def may_reply_to(sent_message)
        !Communique::IncomingMessage.for(recipient).find_by_message_id(sent_message.id).nil?
      end

    end
  end
end
