require 'spec_helper'

describe Communique::ReceivedMessage do
  it{ should respond_to(:mark_as_read) }
  it{ should respond_to(:mark_as_unread) }

  it "is invalid if duplicate" do
    message_reception = create(:message_reception)
    duplicate = build(:message_reception)
    duplicate.should_not be_valid
  end

  context "#mark_as_read" do
    it "should mark message as read" do
      message = create(:message_reception, read: false)
      message.mark_as_read
      message.read.should == true
    end
  end
  context "mark_as_unread" do
    it "should mark message as unread" do
      message = create(:message_reception, read: true)
      message.mark_as_unread
      message.read.should == false
    end
  end
  describe "Class Methods" do
    subject { Communique::ReceivedMessage }
    it{ should respond_to(:deleted) }
    it{ should respond_to(:read) }
    it{ should respond_to(:unread) }
    context "#deleted" do
      it "should show only deleted messages" do
        deleted = create(:message_reception, deleted: true, recipient_id: 1)
        not_deleted = create(:message_reception, deleted: false, recipient_id: 2)
        Communique::ReceivedMessage.deleted.should include(deleted)
        Communique::ReceivedMessage.deleted.should_not include(not_deleted)
      end
    end
  end
end
