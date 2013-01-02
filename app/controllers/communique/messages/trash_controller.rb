module Communique
  module Messages
    class TrashController < ApplicationController
      def index
        sent = sent_by_user.unscoped.trashed.scoped
        received = received_by_user.unscoped.trashed.scoped
        drafts = drafts_for_users.unscoped.trashed.scoped
        @messages = (sent || received || trashed).order("created_at DESC").page(params[:page])
      end
    end
  end
end
