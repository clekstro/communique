require 'spec_helper'

describe Communique::Concerns::Readable do

 context "#mark_as_read" do
    it "marks a mesage as read" do
      message = create(:received_message, read: false)
      message.mark_as_read
      message.read.should be_true
    end
  end

  context "#unmark_as_unread" do
    it "unmarks a mesage as read" do
      message = create(:received_message, read: true)
      message.mark_as_unread
      message.read.should be_false
    end
  end 

end


