require "rails_helper"

RSpec.describe ReferralsController, type: :controller do
  let(:referral) { FactoryBot.create(:referral, from_user: from_user) }
  let(:from_user) { FactoryBot.create(:user) }

  let(:second_user) { FactoryBot.create(:user, name: 'abc', email: 'abc@abc.com') }

  describe "#show" do
    it "updates the referral visited to be true" do
      get :show, params: {referral_token: referral.referral_token, id: second_user.id}

      referral.reload
      expect(referral.visited).to be_truthy
    end

    it 'unknown referral token' do
      get :show, params: {referral_token: 'abcd'}

      expect(response.code).to eq("404")
    end

    it 'catches self visit' do
      get :show, params: {referral_token: referral.referral_token, id: from_user.id}

      expect(flash[:message]).to eq('You tried to refer yourself! Whoops!')
      expect(response).to redirect_to(root_path({id: from_user.id}))
    end

  end

  describe "#update" do
    it "sets the successful attribute on the referral to true" do
      post :update, params: {referral_token: referral.referral_token}

      referral.reload

      expect(referral.successful).to be_truthy
    end
  end
end
