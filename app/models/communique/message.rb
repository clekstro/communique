module Communique
  class Message < ActiveRecord::Base
    attr_accessible :content, :deleted, :draft, :sender_id, :subject
    attr_accessor :recipients

    belongs_to :sender, class_name: "::User"
    validates_presence_of :sender_id, :recipients, :subject, :content
  end
end
