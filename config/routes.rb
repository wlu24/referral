Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "embed#show"

  get 'referrals/show/:referral_token', to: 'referrals#show', as: :referrals_show
  post 'referrals/bind_recipient', to: 'referrals#bind_recipient', as: :referrals_bind_recipient

  post 'referrals/update', to: 'referrals#update'
end
