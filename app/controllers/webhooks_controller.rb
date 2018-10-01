class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new_response
    partner = Partner.find_by(webhook_token: params[:token])

    if partner
      referral = partner.referrals.new

      if request.headers['Content-Type'] == 'application/json'
        referral.original_response = JSON.parse(request.body.read)
      end

      if referral.save
        ActionCable.server.broadcast(
          'referrals',
          partner: partner.slug,
          max_referrals: partner.max_monthly_referrals,
          sent_referrals: partner.referrals.by_month(Time.zone.now.month).size
        )
        head :ok
      else
        head :bad_request
      end
    else
      head :not_found
    end
  end
end
