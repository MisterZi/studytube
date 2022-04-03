FactoryBot.define do
  factory :stock do
    bearer { create(:bearer) }
    name { Faker::Superhero.name }
  end
end
