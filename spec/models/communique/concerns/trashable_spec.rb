require 'spec_helper'

describe Communique::Concerns::Trashable do

 context "#mark_as_trashed" do
    it "marks a mesage as trashed" do
      message = create(:outgoing_message, trashed: false)
      message.mark_as_trashed
      message.trashed.should be_true
    end
  end

  context "#unmark_as_trashed" do
    it "unmarks a mesage as trashed" do
      message = create(:outgoing_message, trashed: true)
      message.unmark_as_trashed
      message.trashed.should be_false
    end
  end 

end


