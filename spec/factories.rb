FactoryGirl.define do
  factory :collaborator do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    fone1 "00000000"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :partner do
    name "Lorem ipsum"
    collaborator
  end
end
