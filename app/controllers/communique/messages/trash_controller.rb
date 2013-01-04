module Communique
  module Messages
    class TrashController < ApplicationController
      def index
        authored = authored_by_user.unscoped.trashed.scoped
        received = received_by_user.unscoped.trashed.scoped
        @messages = (authored || received).order("created_at DESC").page(params[:page])
      end
    end
  end
end
