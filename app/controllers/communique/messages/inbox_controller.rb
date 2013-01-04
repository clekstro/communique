module Communique
  module Messages
    class InboxController < ApplicationController

      # messages scoped to current user for security
      def index
        @messages = Communique::ReceivedMessage.includes(:message => :sender).for(current_user).present
      end

      # prevent anyone but recipient from viewing, replying to, trashing or deleting message
      def show
        @message = find_recipient_message
        redirect_to messages_inbox_index_path and return unless @message
        @message.mark_as_read
      end

      def reply
        original_message = Communique::SentMessage.find_by_id(params[:id])
        if original_message && may_reply_to(original_message)
          @message = Communique::ReplyMessage.new(original_message)
          render template: 'communique/messages/drafts/new'
        else
          redirect_to messages_inbox_index_path
        end
      end

      def trash
        @message = find_recipient_message
        redirect_to messages_inbox_index_path and return unless @message
        @message.mark_as_trashed
        redirect_to(params[:redirect_path] || :back)
      end

      private

      def find_recipient_message
        Communique::ReceivedMessage.for(current_user).find_by_id(params[:id])
      end

      def may_reply_to(sent_message)
        !Communique::ReceivedMessage.for(recipient).find_by_message_id(sent_message.id).nil?
      end

    end
  end
end
