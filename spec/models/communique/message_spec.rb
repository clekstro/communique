require 'spec_helper'

describe Communique::Message do
  it "has a valid factory" do
    build(:message).should be_valid
  end
  it "is invalid without a sender" do
    build(:message, sender_id: nil).should_not be_valid
  end
  it "is invalid without at least one recipient" do
    build(:message, recipients: nil).should_not be_valid
  end
  it "is invalid without a subject" do
    build(:message, subject: nil).should_not be_valid
  end
  it "is invalid without message content" do
    build(:message, content: nil).should_not be_valid
  end
  it "should be draft by default" do
    m = Communique::Message.new
    m.draft.should == true
  end
  it "should not be deleted by default" do
    m = Communique::Message.new
    m.deleted.should == false
  end
  context "interface" do
    it{ should respond_to(:send_message) }
    it{ should respond_to(:mark_as_deleted) }
    it{ should respond_to(:mark_as_draft) } 
  end
  context "#send_message" do
    it "creates reception record for all recipients" do
      user = create(:user)
      message = create(:message, recipients: [user])
      message.send_message
      Communique::MessageReception.find_by_recipient_id(user.id).message_id.should == message.id
    end
  end
  context "#mark_as_deleted" do
    it "marks a mesage as deleted" do
      message = create(:message, deleted: false)
      message.mark_as_deleted
      message.deleted.should == true
    end
  end
  context "#unmark_as_deleted" do
    it "unmarks a mesage as deleted" do
      message = create(:message, deleted: true)
      message.unmark_as_deleted
      message.deleted.should == false
    end
  end
  context "#mark_as_draft" do
    it "marks a message as a draft" do
      message = create(:message, draft: false)
      message.mark_as_draft
      message.draft.should == true
    end
  end
  context "#unmark_as_draft" do
    it "unmarks a message as a draft" do
      message = create(:message, draft: true)
      message.unmark_as_draft
      message.draft.should == false
    end
  end
  describe "Class Methods" do
    subject { Communique::Message }
    it{ should respond_to(:sent_by) }
    it{ should respond_to(:sent) }
    it{ should respond_to(:draft) }
    context "#sent_by" do
      it "should show only those messages sent by sender" do
        sender = create(:user)
        other = create(:user)
        sent_by_sender = create(:message, sender_id: sender.id)
        Communique::Message.sent_by(sender).should include(sent_by_sender)
        Communique::Message.sent_by(other).should_not include(sent_by_sender)
      end
    end
    context "#received_by" do
      it "should return only those messages received by recipient" do
        recipient = create(:user)
        other = create(:user)
        message = create(:message)
        message.recipients = [recipient]
        message.send_message
        Communique::Message.received_by(recipient).should include(message)
      end
    end
    context "#sent" do
      it "should return only sent messages" do
        sent_message = create(:message, draft: false)
        unsent_message = create(:message, draft: true)
        Communique::Message.sent.should include(sent_message)
        Communique::Message.sent.should_not include(unsent_message)
      end
    end
    context "#draft" do
      it "should return only draft messages" do
        draft_message = create(:message, draft: true)
        already_sent = create(:message, draft: false)
        Communique::Message.draft.should include(draft_message)
        Communique::Message.draft.should_not include(already_sent)
      end
    end
  end
end
