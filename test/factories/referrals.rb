FactoryBot.define do
  factory :referral do
    original_response do
      {
        form_response: {
          calculated: { score: 0 },
          definition: {
            fields: [
              { title: 'q1' }, { title: 'q2' }, { title: 'q3' }
            ]
          },
          answers: [
            { text: 'text' }, { boolean: true }, { choice: { label: 'choice' } }
          ]
        }
      }
    end
  end
end
