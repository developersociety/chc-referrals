require 'application_system_test_case'

class PartnerDashboardTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @partner = create(:partner)
  end

  test 'requires log in' do
    visit root_path
    assert_current_path(new_user_session_path)
  end

  test 'default availability displayed' do
    visit root_path
    sign_in
    within('#all-available-referrals') { assert_text('10') }
    within("##{@partner.slug}-available-referrals") { assert_text('10') }
    within('#all-used-referrals') { assert_text('0') }
    within("##{@partner.slug}-used-referrals") { assert_text('0') }
  end

  test 'usage updated when referrals made' do
    create(:referral, partner: @partner)
    visit root_path
    sign_in
    within('#all-available-referrals') { assert_text('9') }
    within("##{@partner.slug}-available-referrals") { assert_text('9') }
    within('#all-used-referrals') { assert_text('1') }
    within("##{@partner.slug}-used-referrals") { assert_text('1') }
  end

  test 'red background when all Referral slots taken' do
    @partner.update(max_monthly_referrals: 0)
    visit root_path
    sign_in

    within("##{@partner.slug}-available-referrals") { assert_text('0') }
    assert_selector('.bg-red', count: 2)

    create(:referral, partner: @partner)
    visit root_path

    within("##{@partner.slug}-available-referrals") { assert_text('-1') }
    assert_selector('.bg-red', count: 2)
  end

  test 'can visit new_partner_referall_path' do
    visit root_path
    sign_in
    assert_link(@partner.name)
  end

  test 'slots has underline' do
    visit root_path
    sign_in
    assert_selector('a', text: 'Slots', class: 'active')
  end
end
