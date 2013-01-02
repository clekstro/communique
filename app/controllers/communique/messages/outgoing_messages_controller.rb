module Communique
  module Messages
    class OutgoingMessagesController < ApplicationController

      def trash
        prevent_sender_forgery
        @message.mark_as_trashed
        redirect_to(params[:redirect_path] || :back)
      end

      def delete
        prevent_sender_forgery
        @message.mark_as_deleted
        redirect_to(params[:redirect_path] || :back)
      end

      def restore
        prevent_sender_forgery
        @message.unmark_as_trashed
        redirect_to(params[:redirect_path] || :back)
      end
    end
  end
end
