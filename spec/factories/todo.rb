FactoryGirl.define do
  factory :todo do
    title { Faker::StarWars.character  }
    body Faker::StarWars.quote
    created_at Time.now.to_s
  end
end

