require 'spec_helper'

describe Communique::ReceivedMessage do
  it{ should respond_to(:mark_as_read) }
  it{ should respond_to(:mark_as_unread) }
  it{ should respond_to(:mark_as_deleted) }
  it{ should respond_to(:unmark_as_deleted) }
  it{ should respond_to(:message_subject) }
  it{ should respond_to(:message_content) }
  it{ should respond_to(:message_sender) }

  it "is invalid if duplicate" do
    received_message = create(:received_message)
    duplicate = build(:received_message)
    duplicate.should_not be_valid
  end

  context "#mark_as_read" do
    it "should mark message as read" do
      message = create(:received_message, read: false)
      message.mark_as_read
      message.read.should == true
    end
  end
  context "mark_as_unread" do
    it "should mark message as unread" do
      message = create(:received_message, read: true)
      message.mark_as_unread
      message.read.should == false
    end
  end
  describe "Class Methods" do
    subject { Communique::ReceivedMessage }
    it{ should respond_to(:deleted) }
    it{ should respond_to(:read) }
    it{ should respond_to(:unread) }
    it{ should respond_to(:present) }
    context "#deleted" do
      it "should show only deleted messages" do
        deleted = create(:received_message, deleted: true, recipient_id: 1)
        not_deleted = create(:received_message, deleted: false, recipient_id: 2)
        Communique::ReceivedMessage.deleted.should include(deleted)
        Communique::ReceivedMessage.deleted.should_not include(not_deleted)
      end
    end
    context "#read" do
      it "should show only read messages" do
        read = create(:received_message, read: true, recipient_id: 1)
        unread = create(:received_message, read: false, recipient_id: 2)
        Communique::ReceivedMessage.read.should include(read)
        Communique::ReceivedMessage.read.should_not include(unread)
      end
    end
    context "#unread" do
      it "returns only unread messages" do
        read = create(:received_message, read: true, recipient_id: 1)
        unread = create(:received_message, read: false, recipient_id: 2)
        Communique::ReceivedMessage.unread.should include(unread)
        Communique::ReceivedMessage.unread.should_not include(read)
      end
    end
  end
end
