FactoryGirl.define do
  factory :message_reception, class: "Communique::MessageReception" do
    message_id 1
    recipient_id 1
    deleted false
    read false
  end
end
