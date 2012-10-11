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
end
