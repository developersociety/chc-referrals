require 'application_system_test_case'

class MonthPickerTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @partner = create(:partner)
    @referral = create(:referral, partner: @partner)
  end

  test 'month picker cannot go into the future' do
    visit root_path
    sign_in
    assert_selector('.grey.no-decoration', text: '❮')
  end

  test 'month_picker has usage' do
    visit root_path
    sign_in
    within("##{@partner.slug}-available-referrals") { assert_text('9') }
  end

  test 'month_picker no usage' do
    visit root_path(date: 1.month.ago)
    sign_in
    within("##{@partner.slug}-available-referrals") { assert_text('10') }
  end

  test 'month_picker has referrals' do
    visit referrals_path
    sign_in
    assert_text(@partner.name)
  end

  test 'month_picker no referrals' do
    visit referrals_path(date: 1.month.ago)
    sign_in
    assert_text('No referrals this month.')
  end

  test 'invalid date returns current day' do
    visit root_path(date: '2020-1')
    sign_in
    assert_text("#{Date::MONTHNAMES[Date.today.month]} Referrals #{Date.today.year}")
  end
end
