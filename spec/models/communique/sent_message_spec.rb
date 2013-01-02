require 'spec_helper'

describe Communique::SentMessage do
  it "has a valid factory" do
    build(:sent_message).should be_valid
  end

  context "#responses" do
    it "returns only those messages responding to self" do
      message = create(:sent_message)
      message_response = create(:sent_message, response_id: message.id)
      message.responses.should include(message_response)
      message.responses.should_not include(message)
    end
  end
  context "#response_to" do
    it "returns message that self is responding to" do
      message = create(:sent_message)
      message_response = create(:sent_message, response_id: message.id)
      message_response.responds_to.should == message
      message.responds_to.should_not == message_response
    end
  end

end
