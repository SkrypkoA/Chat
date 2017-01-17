FactoryGirl.define do
  factory :user_category do
    category
    user
  end
  factory :message do
    content "bla bla bla"
    user
    conversation
  end
  factory :like do
    association :user, factory: :user
    association :picture, factory: :picture
  end
  factory :event do
    association :user, factory: :user
    event_type "GET"
    details "http://localhost:3000/"
  end
  factory :conversations_user do
    conversation
    user
  end
  factory :conversation do
    name "test"
  end
  factory :comment do
    content "test"
    association :picture, factory: :picture#, strategy: :build
    association :user, factory: :user
  end
  factory :category do
    name "test"
    description "test"
  end
  factory :user do
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
    factory :wrong_user do
      email ""
      password ""
      password_confirmation "123"
    end
    factory :second_user do
      email "testuser@gmail.com"
      password "foobar"
      password_confirmation "foobar"
    end
  end

  factory :picture do
    description "test"
    #user User.first
    association :user, factory: :second_user#, strategy: :build
    #category Category.first\
    association :category, factory: :category
    location File.open("/home/skripko_a/pic_dir/alcohol/alc_1.jpg")
  end
end