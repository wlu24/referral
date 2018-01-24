require "rails_helper"

RSpec.describe Referral, type: :model do
  let(:sender) { FactoryBot.build_stubbed(:user) }
  let(:recipient) { FactoryBot.build_stubbed(:user, name: 'Bob Lin', email: 'bl@mail.com') }
  let(:referral) { FactoryBot.build_stubbed(:referral, from_user: sender,
                            to_user: recipient) }

  let(:self_referral) {FactoryBot.build_stubbed(:referral, from_user: sender,
                            to_user: sender)}

  describe 'initialization' do
    it 'knows who the sender is' do
      expect(referral.sender).to eq('Alex Chen')
    end
    it 'knows who the recipient is' do
      expect(referral.recipient).to eq('Bob Lin')
    end
    it 'defaults visit status to false' do
      expect(referral).not_to be_visited
    end
    it 'defaults purchase status to false' do
      expect(referral).not_to be_successful
    end
    it 'has a unique token used for generating a unique share link' do
      # requires create() because of using has_secure_token to generate the token
      ref = FactoryBot.create(:referral, from_user: sender, to_user: recipient)
      expect(ref.referral_token).not_to be_nil
    end
  end

  describe 'referral status' do

    context 'user send a referral to herself' do
      it 'detects self referrals' do
        expect(self_referral).to be_a_self_referral
      end
    end

    context 'recipient clicks the referral link' do

      it 'knows the recipient has visited the link' do
        allow(referral).to receive(:visited).and_return(true)
        expect(referral).to be_visited
      end
      it 'knows the recipient has purchased through referral' do
        allow(referral).to receive(:visited).and_return(true)
        allow(referral).to receive(:successful).and_return(true)
        expect(referral).to be_successful
      end
    end
  end

  describe 'referral status feed text' do

    context 'self_referral' do
      it 'returns self_referral text' do
        text = 'You tried to refer yourself! Whoops!'
        expect(self_referral.to_activity_feed).to eq(text)
      end
    end

    context 'visited' do
      it 'returns visit text' do
        allow(referral).to receive(:visited).and_return(true)

        text = "A friend visited your link, but didn't earn you a reward!"
        expect(referral.to_activity_feed).to eq(text)
      end
    end

    context 'visited and purchased' do
      it 'returns purchase text' do
        allow(referral).to receive(:visited).and_return(true)
        allow(referral).to receive(:successful).and_return(true)

        text = "Your friend #{recipient.name} earned you a reward!"
        expect(referral.to_activity_feed).to eq(text)
      end
    end
  end

end
