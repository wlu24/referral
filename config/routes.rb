Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "embed#show"

  # get 'meta_decks/show/:id', to: 'meta_decks#show', :as => :meta_deck_show
  get 'referrals/show/:referral_token', to: 'referrals#show', as: :referrals_show
end
