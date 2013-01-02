module Communique
  module Messages
    class SentController < OutgoingMessagesController

      def index
        @messages = sent_by_user.page(params[:page])
      end

      def show
        prevent_sender_forgery
      end

      def bulk_delete
        @messages = Communique::SentMessage.find(params[:message_ids])
        @messages.each do |message|
          message.mark_as_deleted if message.was_sent_by?(current_user)
        end
      end

      def restore
        prevent_sender_forgery
        @message.unmark_as_trashed
        redirect_to :back
      end

      private

      def prevent_sender_forgery
        @message = Communique::SentMessage.
          find_by_id_and_sender_id(params[:id], current_user_id)
        redirect_to :messages and return unless @message
      end

      def sent_by_user
        Communique::SentMessage.includes(:sender).for(current_user).present
      end

    end
  end
end
