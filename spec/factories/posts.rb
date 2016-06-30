FactoryGirl.define do
  factory :post do
    title FFaker::Lorem.phrase
    body FFaker::Lorem.paragraphs 3
    author nil
    is_pinned false
    is_draft false
    comments_count 1
  end
end
