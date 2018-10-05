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

  test 'self#used' do
    @subject.save!
    create(:referral, last_state: 'accepted', partner: @subject.partner)
    create(:referral, last_state: 'declined', partner: @subject.partner)
    query = @subject.class.used
    assert_equal(2, query.size)
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
    @subject.original_response = {}
    assert_nil(@subject.response_answers)
  end

  test '#response_answers found' do
    assert_equal({ 'q1' => 'a1', 'q2' => 'a2' }, @subject.response_answers)
  end

  test '#response_identifier found' do
    assert_equal('a1', @subject.response_identifier)
  end

  test '#response_identifier not found' do
    @subject.partner.form_identifier = nil
    assert_equal('-', @subject.response_identifier)
  end

  test '#sequential_id increments by Partner' do
    @subject.save!
    assert_equal(1, @subject.sequential_id)
    assert_equal(2, create(:referral, partner: @subject.partner).sequential_id)
    assert_equal(1, create(:referral, partner: build(:partner)).sequential_id)
  end

  test '#to_param' do
    @subject.save!
    assert_equal(@subject.sequential_id.to_s, @subject.to_param)
  end
end
