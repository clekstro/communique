module Communique
  module Messages
    class InboxController < ApplicationController

      def index
        # messages scoped to current user for security
        @messages = Communique::IncomingMessage.includes(:message => :sender).for(current_user).present
      end

      def show
        prevent_recipient_forgery
        @message.mark_as_read
      end

      def reply
        original_message = Communique::SentMessage.find_by_id(params[:id])
        if original_message && !prevent_reply_forgery(original_message)
          @message = Communique::ReplyMessage.new(original_message)
          render template: 'communique/messages/drafts/new'
        else
          redirect_to :messages_inbox_index
        end
      end

      def trash
        prevent_recipient_forgery
        @message.mark_as_trashed
        redirect_to :messages_inbox_index
      end

      private

      # prevent anyone but recipient from viewing, replying to, trashing or deleting message
      def prevent_recipient_forgery
        @message = Communique::IncomingMessage.
          find_by_id_and_recipient_id(params[:id], current_user_id)
        redirect_to :messages_inbox_index and return unless @message
      end

      def prevent_reply_forgery(sent_message)
        @message = Communique::IncomingMessage.find_by_recipient_id_and_message_id(
          current_user_id, sent_message.id)
        @message.nil?
      end

    end
  end
end
