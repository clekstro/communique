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
  context "interface" do
    it{ should respond_to(:send_message) }
    it{ should respond_to(:mark_as_deleted) }
    it{ should respond_to(:mark_as_draft) } 
  end
  context "#send_message" do
    it "creates reception record for all recipients" do
      user = ::User.create!
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
end
