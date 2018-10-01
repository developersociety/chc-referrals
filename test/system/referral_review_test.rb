require 'application_system_test_case'

class ReferralReviewTest < ApplicationSystemTestCase
  setup do
    create_list(:referral, 3, partner: build(:partner))
  end

  test 'accepts referral' do
    visit referrals_path
    click_link('View', match: :first)
    # TODO: reads details
    # TODO: complete review form to accept
    # TODO: accepts prompt
    # TODO: back to referrals_path with upated status
  end

  test 'declines referral'
  test 'referral order'
  test 'not signed in'
  test 'displays response_identifier'
  test 'missing response_identifier'
  test 'referral not found'
end
