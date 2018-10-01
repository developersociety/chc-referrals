Rails.application.routes.draw do
  get '/:slug/referrals/new', to: 'referrals#new', as: 'new_partner_referral'
  get '/referrals', to: 'referrals#index', as: 'referrals'
  get '/referral/:id', to: 'referrals#show', as: 'referral'

  post '/webhooks/new-response/:token', to: 'webhooks#new_response', as: 'webhooks_new_response'
end
