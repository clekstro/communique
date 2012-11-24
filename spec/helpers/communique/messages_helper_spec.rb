require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the MessagesHelper. For example:
#
# describe MessagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe Communique::MessagesHelper do
  context "#add_comma_padding" do
    it "should return a padded comma-separated string" do
      str = "1,2,3"
      add_comma_padding!(str).should == "1, 2, 3"
    end
  end
  context "#draw_delete_link" do
    it "builds and returns proper delete path depending on action" do
      delete_type = 'sent'
      draw_delete_link('sent').should.respond_with(link_to I18n.t('messages.actions.delete'), destroy_sent_path(message))
    end
  end
end
