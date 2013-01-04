require_relative '../../shared/status_scopes'

module Communique
  class AuthoredMessage < ActiveRecord::Base
    before_save :trim_recipients

    include Communique::Concerns::Deletable
    include Communique::Concerns::Trashable
    include Communique::Concerns::Sendable

    extend Shared::StatusScopes

    attr_accessible :content, :deleted, :draft, :sender_id, :subject, :recipients

    validates_presence_of :sender_id, :recipients, :subject, :content

    default_scope where(deleted: false).order("created_at DESC")

    def initialize
      super
      write_attribute(:deleted, false)
      write_attribute(:trashed, false)
    end

    def self.for(sender)
      where(sender_id: sender.id)
    end

    private

    def trim_recipients
      self.recipients.gsub!(/\s+/, "")
    end
  end
end
