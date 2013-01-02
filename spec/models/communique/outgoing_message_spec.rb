require 'spec_helper'

describe Communique::OutgoingMessage do

  it "has a valid factory" do
    build(:outgoing_message).should be_valid
  end

  it "is invalid without a sender" do
    build(:outgoing_message, sender_id: nil).should_not be_valid
  end
  
  it "is invalid without at least one recipient" do
    build(:outgoing_message, recipients: nil).should_not be_valid
  end

  it "is invalid without a subject" do
    build(:outgoing_message, subject: nil).should_not be_valid
  end

  it "is invalid without message content" do
    build(:outgoing_message, content: nil).should_not be_valid
  end

  it "is not deleted by default" do
    m = Communique::OutgoingMessage.new
    m.deleted.should == false
  end

  it "is not trashed by default" do
    m = Communique::OutgoingMessage.new
    m.trashed.should == false
  end

  context "interface" do
    # includes Sendable
    it{ should respond_to(:send_message) }
    # includes Trashable
    it{ should respond_to(:mark_as_trashed) }
    it{ should respond_to(:unmark_as_trashed) }
    # includes Deletable
    it{ should respond_to(:mark_as_deleted) }
    it{ should respond_to(:unmark_as_deleted) }
    it{ should respond_to(:responses) }
    it{ should respond_to(:sent?) }
  end

  context "#send_message" do
    it "creates received message for all recipients" do
      user = create(:user)
      message = create(:outgoing_message, recipients: user.username)
      message.send_message
      Communique::IncomingMessage.find_by_recipient_id(user.id).message_id.should == message.id
    end
  end

  describe "Class Methods" do
    subject { Communique::OutgoingMessage }
    it{ should respond_to(:for) }
    it{ should respond_to(:present) }

    context "#for" do
      it "should show only those messages sent by sender" do
        sender = create(:user)
        other = create(:user)
        sent_by_sender = create(:outgoing_message, sender_id: sender.id)
        Communique::OutgoingMessage.for(sender).should include(sent_by_sender)
        Communique::OutgoingMessage.for(other).should_not include(sent_by_sender)
      end
    end

    context "#present" do
      it "should return only undeleted messages" do
        deleted_message = create(:outgoing_message, deleted: true)
        present = create(:outgoing_message)
        Communique::OutgoingMessage.present.should include(present)
        Communique::OutgoingMessage.present.should_not include(deleted_message)
      end
    end
  end
end
