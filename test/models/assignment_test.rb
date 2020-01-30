require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @subject = build(:assignment)
  end

  test 'belongs_to Referral' do
    assert_instance_of(Referral, @subject.referral)
  end

  test 'belongs_to User' do
    assert_instance_of(User, @subject.user)
  end
end
