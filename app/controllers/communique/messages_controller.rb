require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :prevent_recipient_forgery, only: [:show, :destroy]
    before_filter :prevent_sender_forgery, only: [:destroy_sent, :show_sent, :edit, :update]

    layout "communique/application", :except => [:index, :sent, :drafts, :trash]

    def new
      @message = Communique::Message.new
    end

    def create
      @message = Communique::Message.new
      @message.attributes = params[:message]
      @message.sender_id = current_user_id
      # check if message to be sent or merely saved as draft
      save_as_draft and return if params[:save_draft]
      save_as_sent
    end

    def edit
      return if (message_not_found? || already_sent?)
      render template: 'communique/messages/new'
    end

    def update
      return if (message_not_found? || already_sent?)
      @message.attributes = params[:message]
      save_as_draft and return if params[:save_draft]
      save_as_sent
    end

    def destroy
      @received_msg.mark_as_deleted
      redirect_to :back
    end

    def destroy_sent
      @sent_msg.mark_as_deleted
      redirect_to :back
    end

    def reply
      original_message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages and return unless original_message
      @message = Communique::Message.new
      original_message_sender = original_message.sender.username
      @message.recipients = original_message_sender
      @message.subject = "Re: " + original_message.subject
      @message.content = "\n#{original_message_sender} wrote:\n" + original_message.content
      render template: 'communique/messages/new'
    end

    def show
      @received_msg.mark_as_read
      @message = @received_msg
    end

    def show_sent
      @message = @sent_msg
      render template: 'communique/messages/show'
    end

    def index
      @messages= received_by_user.page(params[:page])
      render_inbox
    end

    def sent
      @messages = sent_by_user.sent.page(params[:page])
      render_outbox
    end

    def drafts
      @messages = sent_by_user.draft.page(params[:page])
    end

    def destroy_draft
      @message = Communique::Message.find_by_id(params[:id])
      @message.mark_as_deleted if @message
      redirect_to :drafts
    end

    def trash
      sent = sent_by_user.unscoped.deleted.scoped
      received = received_by_user.unscoped.deleted.scoped
      @messages = (sent || received).order("created_at DESC").page(params[:page])
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

    def prevent_sender_forgery
      @sent_msg = Communique::Message.
        find_by_id_and_sender_id(params[:id], current_user_id)
      redirect_to :messages and return unless @sent_msg
    end

    def prevent_recipient_forgery
      @received_msg = Communique::ReceivedMessage.
        find_by_id_and_recipient_id(params[:id], current_user_id)
      redirect_to :messages and return unless @received_msg
    end

    def save_as_draft
      if @message.save
        redirect_to :messages
      else
        render :new
      end
    end

    def save_as_sent
      if @message.save && @message.send_message
        redirect_to :messages
      else
        render :new
      end
    end

    def message_not_found?
      @message = Communique::Message.find_by_id(params[:id])
      redirect_to :messages and return true unless @message
    end

    def already_sent?
      redirect_to :messages and return true if @message.sent?
    end

  end
end
