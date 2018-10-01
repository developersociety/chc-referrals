class ReferralsController < ApplicationController
  def new
    @partner = Partner.active.find_by(slug: params[:slug])

    if @partner
      @referrals = @partner.referrals.by_month(Time.zone.now.month)
    else
      render_status(404)
    end
  end
end
