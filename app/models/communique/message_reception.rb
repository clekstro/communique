require_relative '../../concerns/recipient_actions'

module Communique
  class MessageReception < ActiveRecord::Base
    attr_accessible :deleted, :message_id, :read, :recipient_id
    include Concerns::RecipientActions
  end
end
