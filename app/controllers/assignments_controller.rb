class AssignmentsController < ApplicationController
  before_action :load_referral, except: :new

  def create
    @assignment = Assignment.new(form_params)
    @assignment.referral = @referral

    if @assignment.save!
      redirect_to referral_path(@referral.partner, @referral)
    else
      render :new
    end
  end

  def destroy
    @assignment = Assignment.find_by(referral: @referral, user_id: params[:user_id])
    @assignment.destroy

    redirect_to referral_path(@referral.partner, @referral)
  end

  private

  def form_params
    params.require(:assignment).permit(:user_id)
  end

  def load_referral
    @referral = Referral.find_by(sequential_id: params[:id])
  end
end
