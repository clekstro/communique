require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :prevent_recipient_forgery, only: [:show, :destroy]
    before_filter :prevent_sender_forgery, only: [:destroy_sent, :show_sent]

    def new
      @message = Communique::Message.new
    end

    def create
      @message = Communique::Message.new
      @message.attributes = params[:message]
      @message.sender_id = current_user_id
      # check if message to be sent or merely saved as draft
      return save_as_draft if params[:save_draft]
      save_as_sent
    end

    def edit
      block_if_absent
      block_if_sent
      render template: 'communique/messages/new'
    end

    def update
      block_if_absent
      block_if_sent
      return save_as_draft if params[:save_draft]
      save_as_sent
    end

    def destroy
      @received_msg.mark_as_deleted
      redirect_to :messages
    end

    def destroy_sent
      @sent_msg.mark_as_deleted
      redirect_to :sent
    end

    def reply
      original_message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages unless original_message
      @message = Communique::Message.new
      original_message_sender = original_message.sender.username
      @message.recipients = original_message_sender
      @message.subject = "Re: " + original_message.subject
      @message.content = "\n#{original_message_sender} wrote:\n" + original_message.content
      render template: 'communique/messages/new'
    end

    def show
      @received_msg.mark_as_read
      @message = @received_msg.message
    end

    def show_sent
      render template: 'communique/messages/show'
    end

    def index
      @messages= received_by_user
      render_inbox
    end

    def sent
      @messages = sent_by_user.sent
      render_outbox
    end

    def drafts
      @messages = sent_by_user.draft
    end

    def destroy_draft
      @message = Communique::Message.find_by_id(params[:id])
      @message.mark_as_deleted if @message
      redirect_to :drafts
    end

    def trash
      @messages = sent_by_user.deleted | received_by_user.deleted
      render_inbox
    end

    private

    def sent_by_user
      Communique::Message.sent_by(current_user).present
    end

    def received_by_user
      Communique::ReceivedMessage.by_recipient(current_user).present
    end
   
    def render_inbox
      render :template => 'communique/messages/inbox'
    end

    def render_outbox
      render :template => 'communique/messages/outbox'
    end

    def extract_users(user_list)
      user_list.gsub(/\s+/, "").split(',')
      ::User.where(username: user_list) # TODO: Pull data from engine config instead of hard-coding User
    end

    def prevent_sender_forgery
      @sent_msg = Communique::Message.find_by_id(params[:id])
      redirect_to :messages and return unless @sent_msg
      redirect_to :messages and return unless is_message_sender?(@sent_msg)
    end

    def prevent_recipient_forgery
      @received_msg = Communique::ReceivedMessage.find_by_message_id(params[:id])
      redirect_to :messages and return unless @received_msg
      redirect_to :messages and return unless is_message_recipient?(@received_msg)
    end

    def save_as_draft
      @message.draft = true
      if @message.save
        redirect_to :messages
      else
        render :new
      end
    end

    def save_as_sent
      if @message.save
        @message.send_message
        redirect_to :messages
      else
        render :new
      end
    end

    def block_if_absent
      @message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages unless @message and return
    end

    def block_if_sent
      redirect_to :messages if @message.sent?
    end

    def is_message_recipient?(received_message)
      Communique::Controllers::SecureAccess::is_message_recipient?(received_message, current_user_id)
    end
    
    def is_message_sender?(message)
      Communique::Controllers::SecureAccess::is_message_sender?(message, current_user_id)
    end

    def is_message_party?(message)
      is_message_sender?(message) || is_message_recipient?(message)
    end
  end
end
