FactoryBot.define do
  factory :review do
    referral { build(:referral, partner: build(:partner)) }
    user { build(:user) }
    state { 'accepted' }
  end
end
