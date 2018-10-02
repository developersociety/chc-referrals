class ReviewsController < ApplicationController
  def create
    @referral = Referral.find_by(id: params[:id])
    render_status(404) if @referral.nil?

    @review = @referral.reviews.new(form_params)
    @review.state = lookup_state(params[:commit])

    if @review.save
      redirect_to referral_path(@referral.partner, @referral)
    else
      render '/referrals/show'
    end
  end

  private

  def form_params
    params.require(:review).permit(:notes, :state)
  end

  def lookup_state(key)
    { 'Accept' => 'accepted', 'Decline' => 'declined' }[key]
  end
end
