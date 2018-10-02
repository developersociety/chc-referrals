FactoryBot.define do
  factory :review do
    referral { build(:referral, partner: build(:partner)) }
    state { 'accepted' }
  end
end
