require 'spec_helper'

describe Communique::Concerns::Deletable do

 context "#mark_as_deleted" do
    it "marks a mesage as deleted" do
      message = create(:outgoing_message, deleted: false)
      message.mark_as_deleted
      message.deleted.should be_true
    end
  end

  context "#unmark_as_deleted" do
    it "unmarks a mesage as deleted" do
      message = create(:outgoing_message, deleted: true)
      message.unmark_as_deleted
      message.deleted.should be_false
    end
  end 

end


