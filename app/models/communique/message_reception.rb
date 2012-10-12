require_relative '../../shared/recipient_actions'
require_relative '../../shared/recipient_scopes'
require_relative '../../shared/shared_scopes'
require_relative '../../shared/shared_actions'

module Communique
  class MessageReception < ActiveRecord::Base
    attr_accessible :deleted, :message_id, :read, :recipient_id
    include Shared::RecipientActions
    include Shared::SharedActions
    extend Shared::RecipientScopes
    extend Shared::SharedScopes

  end
end
