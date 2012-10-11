require 'spec_helper'

describe Communique::Message do
  it "has a valid factory" do
    build(:message).should be_valid
  end
end
