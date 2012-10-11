module Communique
  class Message < ActiveRecord::Base
    attr_accessible :content, :deleted, :draft, :sender_id, :subject
    attr_accessor :recipients
  end
end
