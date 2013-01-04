module Communique
  module Messages
    class OutgoingMessagesController < ApplicationController

      def trash
        @message = author_message
        back_to_inbox and return unless @message
        @message.mark_as_trashed
        redirect_to(params[:redirect_path] || :back)
      end

      def delete
        @message = author_message
        back_to_inbox and return unless @message
        @message.mark_as_deleted
        redirect_to(params[:redirect_path] || :back)
      end

      def restore
        @message = author_message
        back_to_inbox and return unless @message
        @message.unmark_as_trashed
        redirect_to(params[:redirect_path] || :back)
      end

      private

      def author_message
        authored_by_user.find_by_id(params[:id])
      end

      def back_to_inbox
        redirect_to messages_inbox_index_path
      end
    end
  end
end
