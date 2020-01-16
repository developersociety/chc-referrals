class PartnersController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = params[:date]&.to_date || Date.today

    @usage ||= Referral.joins(:partner).used
                       .by_month(@date, col: 'referrals.created_at')
                       .group('partners.slug').size

    @partners = Partner.active.order(:name)

    @total_available = @partners.sum(:max_monthly_referrals) - @usage.values.sum
  end
end
