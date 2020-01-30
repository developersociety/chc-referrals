Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  root 'partners#index'

  get '/:slug/referrals/new', to: 'referrals#new', as: 'new_partner_referral'
  get '/referrals', to: 'referrals#index', as: 'referrals'
  get '/:slug/referrals/:id', to: 'referrals#show', as: 'referral'

  get  '/:slug/referral/:id/reviews/new', to: 'reviews#new', as: 'new_referral_review'
  post '/:slug/referral/:id/reviews/new', to: 'reviews#create'

  get    '/:slug/referrals/:id/assignments/new', to: 'assignments#new', as: 'new_assignment'
  post   '/:slug/referrals/:id/assignments/new', to: 'assignments#create'
  delete '/:slug/referrals/:id/assignments/:user_id/', to: 'assignments#destroy', as: 'assignment'

  post '/webhooks/new-response/:token', to: 'webhooks#new_response', as: 'webhooks_new_response'
end
