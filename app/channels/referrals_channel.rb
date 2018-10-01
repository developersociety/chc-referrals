class ReferralsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'referrals'
  end
end
