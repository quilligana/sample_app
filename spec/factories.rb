FactoryGirl.define do
  factory :user do
    name     "Aidan Quilligan"
    email    "aidan@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end