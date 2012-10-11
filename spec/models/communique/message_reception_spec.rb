require 'spec_helper'

describe Communique::MessageReception do
  it{ should respond_to(:mark_as_read) }
  it{ should respond_to(:mark_as_unread) }

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
    subject { Communique::MessageReception }
    it{ should respond_to(:deleted) }
    it{ should respond_to(:read) }
    it{ should respond_to(:unread) }
    context "#deleted" do
      it "should show only deleted messages" do
        deleted = create(:message_reception, deleted: true)
        not_deleted = create(:message_reception, deleted: false)
        Communique::MessageReception.deleted.should include(deleted)
        Communique::MessageReception.deleted.should_not include(not_deleted)
      end
    end
  end
end
