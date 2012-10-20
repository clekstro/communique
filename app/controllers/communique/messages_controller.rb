require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def new
      @message = Communique::Message.new
      @count = unread_count
    end

    def create
      @message = Communique::Message.new
      @message.attributes = params[:message]
      @message.sender_id = current_user_id
      @message.recipients = extract_users(params[:message][:recipients])
      if @message.save
        @message.send_message
        redirect_to :messages
      else
        render :new
      end
    end
  
    def edit
      @message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages if @message.sent?
      @count = unread_count
      # render another page if trying to edit a message that was already sent
    end
  
    def update
      @message = Communique::Message.find(params[:id])
      redirect_to :messages if @message.sent?
      # render another page if trying to edit a message that was already sent
    end

    def show
      reception = Communique::MessageReception.find_by_message_id(params[:id])
      redirect_to :messages unless reception
      reception.mark_as_read
      @message = reception.message
      @count = unread_count
    end

    def show_sent
      @message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages unless @message
      @count = unread_count
      render 'communique/messages/show'
    end
  
    def index
      @messages= received_by_user
      @count = unread_count
      render_inbox
    end
  
    def sent
      @messages = sent_by_user
      @count = unread_count
      render_outbox
    end
  
    def drafts
      @messages = sent_by_user.draft
      @count = unread_count
      render_inbox
    end
  
    def trash
      @messages = sent_by_user.deleted | received_by_user.deleted
      @count = unread_count
      render_inbox
    end
  
    # def read
    #   @messages = received_by_user.read
    # end
  
    # def unread
    #   @messages = received_by_user.unread
    # end

    private

    def sent_by_user
      Communique::Message.sent_by(current_user)
    end
    def received_by_user
      Communique::Message.received_by(current_user)
    end
    def render_inbox
      render :template => 'communique/messages/inbox'
    end
    def render_outbox
      render :template => 'communique/messages/outbox'
    end
    def unread_count
      Communique::MessageReception.by_recipient(current_user).unread.count
    end
    def extract_users(user_list)
      user_list.gsub(/\s+/, "").split(',')
      ::User.where(username: user_list)
      # TODO: replace direct call to user wtih engine config
    end
    def restrict_to_recipient
      redirect_to :messages unless is_message_recipient?(message_reception_id)
    end
    def restrict_to_sender
      redirect_to :messages unless is_message_sender?(message_id)
    end
    def is_message_recipient?(message_reception_id)
      Communique::Controllers::SecureAccess::is_message_recipient?(message_reception_id)
    end
    def is_message_sender?(message_id)
      Communique::Controllers::SecureAccess::is_message_sender?(message_id)
    end
    def current_user_id
      current_user.id
    end
  end
end
