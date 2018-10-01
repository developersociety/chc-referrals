FactoryBot.define do
  factory :partner do
    sequence(:name) { |n| "Partner #{n}" }
    form_identifier { 'q1' }
    form_url { 'https://admin.typeform.com/to/cVa5IG' }
    max_monthly_referrals { 10 }
  end
end
