require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  setup do
    @subject = build(:review)
  end

  test('valid') { assert(@subject.valid?) }

  test 'belongs_to Referral' do
    assert_instance_of(Referral, @subject.referral)
  end

  test 'belongs_to User' do
    assert_instance_of(User, @subject.user)
  end

  test '#position increments by Referral' do
    @subject.save!
    assert_equal(1, @subject.position)
    assert_equal(2, create(:review, referral: @subject.referral).position)
    assert_equal(1, create(:review).position)
  end

  test '#state in list' do
    assert_present(:state, msg: 'is not included in the list')
  end

  test 'creating record sets Referral#last_state' do
    assert_equal('review', @subject.referral.last_state)
    @subject.save!
    assert_equal('accepted', Referral.last.last_state)
  end

  test 'updating #state does not update Referral#last_state' do
    @subject.save!
    assert_equal('accepted', Referral.last.last_state)
    @subject.update(state: 'declined')
    assert_equal('accepted', Referral.last.last_state)
  end
end
