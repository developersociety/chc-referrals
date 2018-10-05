require 'test_helper'

class PartnerTest < ActiveSupport::TestCase
  setup do
    @subject = build(:partner)
  end

  test('valid') { assert(@subject.valid?) }

  test 'has_many Referrals' do
    create_list(:referral, 2, partner: @subject)
    assert_equal(2, @subject.referrals.size)
  end

  test 'self#active' do
    @subject.save!
    query = @subject.class.active
    assert_equal(1, query.size)
    @subject.update!(accepting_referrals: false)
    assert_equal(0, query.size)
  end

  test '#accepting_referrals default' do
    assert_equal(true, @subject.accepting_referrals)
  end

  test '#accepting_referrals in list' do
    assert_present(:accepting_referrals, msg: 'is not included in the list')
  end

  test '#can_accept_referrals? true' do
    @subject.max_monthly_referrals = 1
    create(:referral, partner: @subject, last_state: 'declined')
    assert(@subject.can_accept_referrals?)
  end

  test '#can_accept_referrals? false' do
    @subject.max_monthly_referrals = 1
    create(:referral, partner: @subject)
    assert_not(@subject.can_accept_referrals?)
  end

  test '#form_url present' do
    assert_present(:form_url)
  end

  test '#form_url format' do
    @subject.form_url = 'example.com'
    @subject.valid?
    assert_error(:form_url, 'must begin with http:// or https://')
  end

  test '#max_monthly_referrals present' do
    assert_present(:max_monthly_referrals)
  end

  test '#max_monthly_referrals greater than 0' do
    @subject.max_monthly_referrals = -1
    @subject.valid?
    assert_error(:max_monthly_referrals, 'must be greater than or equal to 0')
  end

  test '#name present' do
    assert_present(:name)
  end

  test '#name unique' do
    assert_unique(:name)
  end

  test '#slug present' do
    assert_present(:slug)
  end

  test '#slug unique' do
    assert_unique(:slug)
  end

  test '#slug is parameterized name' do
    @subject.name = 'Super Name!'
    assert_equal('super-name', @subject.slug)
  end

  test '#webhook_token' do
    assert_nil(@subject.webhook_token)
    @subject.save
    assert_not_nil(@subject.webhook_token)
  end

  test '#to_param' do
    assert_equal(@subject.slug, @subject.to_param)
  end
end
