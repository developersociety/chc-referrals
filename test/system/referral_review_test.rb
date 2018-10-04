require 'application_system_test_case'

class ReferralReviewTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    @partner = create(:partner)
    @referral = create(:referral, partner: @partner)
  end

  test 'accepts referral' do
    visit root_path
    sign_in
    click_link('Referrals')
    find('a.row', match: :first).click
    click_button('Accept')
    page.accept_confirm

    assert_text("#{@user.first_name} accepted")
    assert_current_path(referral_path(@partner, @referral))
  end

  test 'declines referral' do
    visit referral_path(@partner, @referral)
    sign_in
    click_button('Decline')
    page.accept_confirm

    assert_text("#{@user.first_name} declined")
    assert_current_path(referral_path(@partner, @referral))
  end

  test 'dismiss confirm for accept' do
    visit referral_path(@partner, @referral)
    sign_in
    click_button('Accept')
    page.dismiss_confirm

    assert_no_text("#{@user.first_name} accepted")
  end


  test 'dismiss confirm for decline' do
    visit referral_path(@partner, @referral)
    sign_in
    click_button('Decline')
    page.dismiss_confirm

    assert_no_text("#{@user.first_name} declined")
  end

  test 'lists answers' do
    visit referral_path(@partner, @referral)
    sign_in
    %w[q1 a1 q2 a2].each { |t| assert_text(t) }
  end

  test 'not signed in referrals_path' do
    visit referrals_path
    assert_current_path(new_user_session_path)
  end

  test 'not signed in referral_path' do
    visit referral_path(@partner, @referral)
    assert_current_path(new_user_session_path)
  end

  test 'referral not found' do
    visit referral_path(@partner, 'missing')
    sign_in
    assert_text("The page you were looking for doesn't exist.")
  end

  test 'status_text(declined) is red on index and show'
  test '#requires_review(state) referrals to review are black'
  test 'referrals has underline'
end
