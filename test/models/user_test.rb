require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @subject = build(:user)
  end

  test('valid') { assert(@subject.valid?) }

  test 'has_many Reviews' do
    create_list(:review, 2, user: @subject)
    assert_equal(2, @subject.reviews.size)
  end

  test '#first_name present' do
    assert_present(:first_name)
  end

  test '#last_name present' do
    assert_present(:last_name)
  end
end
