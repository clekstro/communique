FactoryGirl.define do
  factory :received_message, class: "Communique::ReceivedMessage" do
    message_id 1
    recipient_id 1
    deleted false
    read false
  end
end
