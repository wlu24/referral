require "rails_helper"

RSpec.describe Referral, type: :model do
  let(:sender) { User.new(name: 'Alex Chen', email: 'ac@mail.com') }
  let(:recipient) { User.new(name: 'Bob Lin', email: 'bl@mail.com') }

  describe 'initialization' do
    let(:referral) { Referral.new(from_user: sender, to_user: recipient,
                                  referral_token: 'abcde') }

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
  end

  describe 'referral status' do

    context 'user send a referral to herself' do
      let(:referral) { Referral.new(from_user: sender, to_user: sender,
                                    referral_token: 'abcde') }

      it 'detects self referrals' do
        expect(referral).to be_a_self_referral
      end
    end

    context 'recipient clicks the referral link' do
      let(:referral) { Referral.new(from_user: sender, to_user: recipient,
                                    referral_token: 'abcde') }

      it 'knows the recipient has visited the link' do
        referral.link_clicked
        expect(referral).to be_visited
      end
      it 'knows the recipient has purchased through referral' do
        referral.link_clicked
        referral.purchase_made
        expect(referral).to be_successful
      end
    end
  end

  describe 'referral status feed text' do

  end
end
