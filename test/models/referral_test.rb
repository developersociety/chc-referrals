require 'test_helper'

class ReferralTest < ActiveSupport::TestCase
  setup do
    @subject = build(:referral, partner: build(:partner))
  end

  test('valid') { assert(@subject.valid?) }

  test 'belongs_to Partner' do
    assert_instance_of(Partner, @subject.partner)
  end

  test 'self#by_month' do
    @subject.save!
    query = @subject.class.by_month(Time.zone.now.month)
    assert_equal(1, query.size)
  end

  test '#emails' do
    email = 'email@example.com'
    @subject.original_response = {
      form_response: { answers: [{ email: email }] }
    }
    assert_equal([email], @subject.emails)
  end

  test '#last_state default' do
    assert_equal('review', @subject.last_state)
  end

  test '#last_state review' do
    @subject.original_response = { form_response: { calculated: { score: 0 } } }
    assert_equal('review', @subject.last_state)
  end

  test '#last_state declined' do
    @subject.original_response = { form_response: { calculated: { score: -1 } } }
    assert_equal('declined', @subject.last_state)
  end

  test '#last_state in list' do
    assert_present(:last_state, msg: 'is not included in the list')
  end

  test '#original_response present' do
    assert_present(:original_response)
  end

  test '#response_answers not found' do
    assert_nil(@subject.response_answers)
  end

  test '#response_answers found' do
    @subject.original_response = {
      form_response: {
        definition: { fields: [{ title: 'q1' }, { title: 'q2' }] },
        answers: [{ text: 'a1' }, { text: 'a2' }]
      }
    }
    assert_equal({ 'q1' => 'a1', 'q2' => 'a2' }, @subject.response_answers)
  end
end
