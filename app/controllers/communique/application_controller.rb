module Communique
  class ApplicationController < ActionController::Base
    before_filter :authenticate_user!
    before_filter :add_unread_count

    def current_user_id
      current_user.id
    end

    def add_unread_count
      @count = received_by_user.unread.count
    end

    def sent_by_user
      Communique::OutgoingMessage.for(current_user).present
    end

    def received_by_user
      Communique::IncomingMessage.for(current_user).present
    end

    def drafts_for_users
      Communique::DraftMessage.for(current_user).present
    end

  end
end
