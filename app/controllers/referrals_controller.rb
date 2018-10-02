class ReferralsController < ApplicationController
  def new
    @partner = Partner.active.find_by(slug: params[:slug])

    if @partner
      @referrals = @partner.referrals.by_month(Time.zone.now.month)
      @used_referrals = @referrals.used
    else
      render_status(404)
    end
  end

  def index
    @referrals = Referral.order(created_at: :desc)
  end

  def show
    @referral = Referral.find_by(id: params[:id])
    render_status(404) if @referral.nil?
  end
end
