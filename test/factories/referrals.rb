FactoryBot.define do
  factory :referral do
    original_response {
      {
        form_response: {
          calculated: { score: 0 },
          definition: { fields: [{ title: 'q1' }, { title: 'q2' }] },
          answers: [{ text: 'a1' }, { text: 'a2' }]
        }
      }
    }
  end
end
