require 'application_system_test_case'

class ReferralAssignmentTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @partner = create(:partner)
    @referral = create(:referral, partner: @partner)
    visit root_path
    sign_in
    click_link('Referrals')
    find('a.row', match: :first).click
  end

  test 'can assign user to refferal' do
    select(@user.full_name)
    click_on('Assign')

    assert_link('Unassign', count: 1)
  end

  test 'cannot assign same user twice' do
    user2 = create(:user)
    select(@user.full_name)
    click_on('Assign')
    select(user2.full_name)
    click_on('Assign')

    assert_link('Unassign', count: 2)
  end

  test 'can unassign user to refferal' do
    select(@user.full_name)
    click_on('Assign')
    click_on('Unassign')
    page.accept_confirm

    assert_no_link('(Unassign)', count: 1)
  end
end
