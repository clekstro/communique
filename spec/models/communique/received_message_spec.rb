require 'spec_helper'

describe Communique::ReceivedMessage do
  # includes Readable
  it{ should respond_to(:mark_as_read) }
  it{ should respond_to(:mark_as_unread) }
  # includes Deletable
  it{ should respond_to(:mark_as_deleted) }
  it{ should respond_to(:unmark_as_deleted) }
  # includes Trashable
  it{ should respond_to(:mark_as_trashed) }
  it{ should respond_to(:unmark_as_trashed) }
  it{ should respond_to(:subject) }
  it{ should respond_to(:content) }
  it{ should respond_to(:sender) }

  it "is invalid if duplicate" do
    received_message = create(:received_message)
    duplicate = build(:received_message)
    duplicate.should_not be_valid
  end

  it "is unread by default" do
    received_message = Communique::ReceivedMessage.new
    received_message.read.should be_false
  end

  it "is undeleted by default" do
    received_message = Communique::ReceivedMessage.new
    received_message.deleted.should be_false
  end

  it "is untrashed by default" do
    received_message = Communique::ReceivedMessage.new
    received_message.trashed.should be_false
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
    it{ should respond_to(:trashed) }
    it{ should respond_to(:read) }
    it{ should respond_to(:unread) }
    it{ should respond_to(:present) }

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

     context "#for" do
      it "should return only those messages received by recipient" do
        recipient = create(:user)
        other = create(:user)
        message = create(:outgoing_message)
        received_message = create(:received_message, message_id: message.id, recipient_id: recipient.id)
        Communique::ReceivedMessage.for(recipient).should include(received_message)
        Communique::ReceivedMessage.for(other).should_not include(received_message)
      end
    end
  end
end
