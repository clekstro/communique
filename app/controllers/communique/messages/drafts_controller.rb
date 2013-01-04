module Communique
  module Messages
    class DraftsController < AuthoredMessagesController
      # only sender can view, edit, send, trash or delete message

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
        @message = find_draft
        redirect_to(action: 'index') and return unless @message
      end

      def edit
        @message = find_draft
        redirect_to(action: 'index') and return unless @message
      end

      def send_draft
        @message = find_draft
        save_as_sent
      end

      def index
        @messages = drafts_for_user.page(params[:page])
      end

      private

      def drafts_for_user
        DraftMessage.includes(:sender).for(current_user).present
      end

      def find_draft
        drafts_for_user.find_by_id(params[:id])
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
