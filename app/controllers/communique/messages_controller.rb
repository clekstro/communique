require_dependency "communique/application_controller"

module Communique
  class MessagesController < ApplicationController
    before_filter :authenticate_user!
    
    def new
        @message = Communique::Message.new
    end
  
    def edit
        @message = Communique::Message.find(params[:id])
    end
  
    def update
        @message = Communique::Message.find(params[:id])
    end
  
    def inbox
        @messages = received_by_user
    end
  
    def outbox
        @messages = sent_by_user
    end
  
    def drafts
        @messages = sent_by_user.draft
    end
  
    def trash
        @messages = sent_by_user.deleted | received_by_user.deleted
    end
  
    def read
        @messages = received_by_user.read
    end
  
    def unread
        @messages = received_by_user.unread
    end

    private

    def sent_by_user
        Communique::Message.sent_by(current_user.id)
    end
    def received_by_user
        Communique::Message.received_by(current_user.id)
    end
  end
end
