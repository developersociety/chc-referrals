class PartnersController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = params[:date]&.to_date || Date.today

    @usage ||= Referral.joins(:partner).used
                       .by_month(@date.month, col: 'referrals.created_at')
                       .group('partners.slug').size

    @partners = Partner.active.all
  end
end
