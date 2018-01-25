require "rails_helper"

RSpec.describe ReferralsController, type: :controller do
  let(:referral) { FactoryBot.create(:referral, from_user: from_user) }
  let(:from_user) { FactoryBot.create(:user) }

  describe "#show" do
    it "updates the referral visited to be true" do
      get :show, params: {referral_token: referral.referral_token}

      referral.reload
      expect(referral.visited).to be_truthy
    end

    it 'unknown referral token' do
      get :show, params: {referral_token: 'abcd'}

      expect(response.code).to eq("404")
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
