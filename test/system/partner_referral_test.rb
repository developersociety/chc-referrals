require 'application_system_test_case'

class PartnerReferralTest < ApplicationSystemTestCase
  setup do
    @partner = create(:partner)
  end

  test 'Partner not found' do
    visit new_partner_referral_path('missing')
    assert_text("The page you were looking for doesn't exist.")
  end

  test 'only active Partners' do
    @partner.update(accepting_referrals: false)
    visit new_partner_referral_path(@partner)
    assert_text("The page you were looking for doesn't exist.")
  end

  test 'make Referral' do
    visit new_partner_referral_path(@partner)

    page.within_frame(find('iframe')) do
      find('.general').click
      find('.submit', visible: false).click
    end

    send_fake_webhook_request(@partner)

    within("##{@partner.slug}-available-referrals") { assert_text('9') }
    within("##{@partner.slug}-used-referrals") { assert_text('1') }
  end

  test 'all Referral slots taken' do
    @partner.update(max_monthly_referrals: 0)
    visit new_partner_referral_path(@partner)
    assert_text('No more referral slots available this month.')
    assert_link('Make an Emergency referral')
  end

  test 'red background when all Referral slots taken' do
    @partner.update(max_monthly_referrals: 0)
    visit new_partner_referral_path(@partner)

    within("##{@partner.slug}-available-referrals") { assert_text('0') }
    assert_selector('.bg-red', count: 1)

    send_fake_webhook_request(@partner)

    within("##{@partner.slug}-available-referrals") { assert_text('-1') }
    assert_selector('.bg-red', count: 1)
  end

  test 'shows remaining availability' do
    create(:referral, partner: @partner)
    create(:referral, partner: @partner, last_state: 'accepted')
    create(:referral, partner: @partner, last_state: 'declined')
    visit new_partner_referral_path(@partner)
    within("##{@partner.slug}-available-referrals") { assert_text('8') }
  end

  test 'real time update per Partner' do
    @partner2 = create(:partner)
    visit new_partner_referral_path(@partner)
    send_fake_webhook_request(@partner2)
    within("##{@partner.slug}-used-referrals") { assert_text('0') }
  end

  test 'form hidden when all Referrals used' do
    @partner.update(max_monthly_referrals: 1)
    visit new_partner_referral_path(@partner)
    send_fake_webhook_request(@partner)
    assert_text('No more referral slots available this month.')
  end

  test 'hides list if logged out' do
    visit new_partner_referral_path(@partner)
    assert_no_text('Sent Referrals')
  end

  test 'hides list if no referrals' do
    @user = create(:user)
    visit new_user_session_path
    sign_in
    visit new_partner_referral_path(@partner)
    assert_no_text('Sent Referrals')
  end

  test 'shows list if logged in and referrals present' do
    create(:referral, partner: @partner)
    @user = create(:user)
    visit new_user_session_path
    sign_in
    visit new_partner_referral_path(@partner)
    assert_text('Sent Referrals')
    assert_selector('.row.with-border', count: 1)
  end

  def send_fake_webhook_request(partner)
    fake_webhook_request(
      webhooks_new_response_path(partner.webhook_token),
      headers: { 'Content-Type' => 'application/json' },
      body: { event_id: 'LtWXD3crgy' }
    )
  end
end
