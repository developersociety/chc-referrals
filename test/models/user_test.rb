require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @subject = build(:user)
  end

  test('valid') { assert(@subject.valid?) }

  test 'has_many Assignments' do
    create_list(:assignment, 2, user: @subject)
    assert_equal(2, @subject.assignments.size)
  end

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

  test '#full_name' do
    expected = "#{@subject.first_name} #{@subject.last_name}"
    assert_equal(expected, @subject.full_name)
  end
end
