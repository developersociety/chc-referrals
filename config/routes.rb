Rails.application.routes.draw do
  get '/:slug/referrals/new', to: 'referrals#new', as: 'new_partner_referral'
  post '/webhooks/new-response/:token', to: 'webhooks#new_response', as: 'webhooks_new_response'
end
