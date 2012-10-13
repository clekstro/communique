require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def new
      @message = Communique::Message.new
    end

    def create
      @message = Communique::Message.new
      @message.attributes = params[:message]
      @message.sender_id = current_user.id
      @message.recipients = extract_users(params[:message][:recipients])
      if @message.save
        @message.send_message
        redirect_to :inbox
      else
        render :new
      end
    end
  
    def edit
      @message = Communique::Message.find(params[:id])
      # render another page if trying to edit a message that was already sent
    end
  
    def update
      @message = Communique::Message.find(params[:id])
      # render another page if trying to edit a message that was already sent
    end
  
    def inbox
      @messages= received_by_user
      @count = unread_count
      render_inbox
    end
  
    def outbox
      @messages = sent_by_user
      @count = unread_count
      render_inbox
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
      messages = Communique::Message.sent_by(current_user)
    end
    def received_by_user
      Communique::Message.received_by(current_user)
    end
    def render_inbox
      render :template => 'communique/messages/inbox'
    end
    def unread_count
      Communique::MessageReception.by_recipient(current_user).unread.count
    end
    def extract_users(user_list)
      user_list.gsub(/\s+/, "").split(',')
      ::User.where(username: user_list)
    end
  end
  # BIG IDEA! You want to grab the count info while we're already checking the MessageReceptions!  multiple return/assignment will work brilliantly here!
end
