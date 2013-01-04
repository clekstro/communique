module Communique
  module Messages
    class SentController < OutgoingMessagesController

      # scope sent messages by user for security
      def index
        @messages = sent_by_user.page(params[:page])
      end

      # only allow viewing, trashing, deleting if user is message owner
      def show
        @message = find_sender_message
        redirect_to :messages and return unless @message
      end

      def bulk_delete
        @messages = sent_by_user.find(params[:message_ids])
        @messages.each do |m|
          m.mark_as_deleted if m.was_sent_by?(current_user)
        end
      end

      private

      def find_sender_message
        sent_by_user.find_by_id(params[:id])
      end

      def sent_by_user
        Communique::SentMessage.includes(:sender).for(current_user).present
      end

    end
  end
end
