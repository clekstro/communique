FactoryGirl.define do
  factory :outgoing_message, class: "Communique::AuthoredMessage" do
    sender_id 1
    subject "Test Subject"
    content "Message Content"
    deleted false
    trashed false
    recipients "johndoe, janedoe"

    factory :sent_message, class: "Communique::SentMessage" do
      type "Communique::SentMessage"
    end

    factory :draft_message, class: "Communique::DraftMessage" do
      type "Communique::DraftMessage"
    end

  end
end
