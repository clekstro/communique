require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def new
      @message = Communique::Message.new
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
      @messages = received_by_user
      render_inbox
    end
  
    def outbox
      @messages = sent_by_user
      render_inbox
    end
  
    def drafts
      @messages = sent_by_user.draft
      render_inbox
    end
  
    def trash
      @messages = sent_by_user.deleted | received_by_user.deleted
      render_inbox
    end
  
    def read
      @messages = received_by_user.read
    end
  
    def unread
      @messages = received_by_user.unread
    end

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
  end
end
