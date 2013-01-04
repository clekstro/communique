module Communique
  module Messages
    class InboxController < ApplicationController

      def index
        # messages scoped to current user for security
        @messages = Communique::IncomingMessage.includes(:message => :sender).for(current_user).present
      end

      def show
        @message = find_recipient_message
        @message.mark_as_read if @message
        redirect_to :messages_inbox_index
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
        @message.mark_as_trashed if @message
        redirect_to :messages_inbox_index
      end

      private

      # prevent anyone but recipient from viewing, replying to, trashing or deleting message
      def find_recipient_message
        Communique::IncomingMessage.find_by_id_and_recipient_id(params[:id], current_user_id)
      end

      def may_reply_to(sent_message)
        !Communique::IncomingMessage.find_by_recipient_id_and_message_id(current_user_id, sent_message.id).nil?
      end

    end
  end
end
