module Communique
  module Messages
    class DraftsController < OutgoingMessagesController

      def new
        @message = DraftMessage.new
      end

      def create
        @message = Communique::DraftMessage.new
        @message.attributes = params[:draft_message]
        @message.sender_id = current_user_id
        # check if message to be sent or merely saved as draft
        save_as_draft and return if params[:save_draft]
        save_as_sent
      end

      def show
        prevent_sender_forgery
      end

      def edit
        prevent_sender_forgery
      end

      def send_draft
        prevent_sender_forgery
        save_as_sent
      end

      def index
        @messages = drafts_for_user.page(params[:page])
      end

      private

      def drafts_for_user
       DraftMessage.includes(:sender).for(current_user).present
      end

      def prevent_sender_forgery
        # only sender can view, trash or delete message
        @message = DraftMessage.find_by_id_and_sender_id(params[:id], current_user_id)
        redirect_to(action: 'index') and return unless @message
      end

      def save_as_draft
        if @message.save
          redirect_to(action: 'index')
        else
          render :new
        end
      end

      def save_as_sent
        if @message.save && @message.send_message
          redirect_to(action: 'index')
        else
          render :new
        end
      end 

    end
  end
end
