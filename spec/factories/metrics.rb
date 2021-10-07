FactoryBot.define do
  factory :metric do
    name { "My metric" }
    value { 10.0 }
    timestamp { Time.current }
  end
end
