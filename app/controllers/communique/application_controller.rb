module Communique
  class ApplicationController < ActionController::Base
    before_filter :authenticate_user!
    before_filter :add_unread_count

    def current_user_id
      current_user.id
    end
    
    def add_unread_count
      @count = Communique::ReceivedMessage.by_recipient(current_user).present.unread.count
    end
  end
end
