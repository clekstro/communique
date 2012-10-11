FactoryGirl.define do
  factory :message, class: "Communique::Message" do
    sender_id 1
    subject "Test Subject"
    content "Message Content"
    draft false
    deleted false
    recipients %w[johndoe, janedoe]
  end
end
