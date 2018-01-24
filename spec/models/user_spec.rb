require 'rails_helper'

RSpec.describe User, type: :model do
  # sender with no referral sent
  let(:sender_no_ref) { FactoryBot.build_stubbed(:user) }

  # sender with 1 referral sent
  let(:sender) { FactoryBot.build_stubbed(:user, sent_referrals: [referral] ) }
  let(:recipient) { FactoryBot.build_stubbed(:user, name: 'Abby B', email: 'al@mail.com') }
  let(:referral) { FactoryBot.build_stubbed(:referral, to_user: recipient, referral_token: '12345') }

  # sender with 3 referral sent
  let(:sender_multi_refs) { FactoryBot.build_stubbed(:user, sent_referrals:[ref1, ref2, ref3] ) }
  let(:recipient1) { FactoryBot.build_stubbed(:user, name: 'Bella C', email: 'bc@mail.com') }
  let(:recipient2) { FactoryBot.build_stubbed(:user, name: 'Chloe D', email: 'cd@mail.com') }
  let(:recipient3) { FactoryBot.build_stubbed(:user, name: 'Daisy E', email: 'de@mail.com') }
  let(:ref1) { FactoryBot.build_stubbed(:referral, to_user: recipient1, referral_token: '1') }
  let(:ref2) { FactoryBot.build_stubbed(:referral, to_user: recipient2, referral_token: '2') }
  let(:ref3) { FactoryBot.build_stubbed(:referral, to_user: recipient3, referral_token: '3') }

  describe 'calculating total reward point' do
    context 'no referral sent yet' do
      specify { expect(sender_no_ref.total_reward_point).to eq(0) }
    end
    context 'referrals sent' do
      it 'knows the total reward point is still 0 when a friend only visited the link' do
        expect(sender.sent_referral_count).to eq(1)
        expect(sender.total_reward_point).to eq(0)
      end
      it 'detects a purchase made through referral' do
        allow(referral).to receive(:visited).and_return(true)
        allow(referral).to receive(:successful).and_return(true)
        expect(sender.sent_referral_count).to eq(1)
        expect(sender.total_reward_point).to eq(1)
      end
      it 'detects multiple purchases made through referral' do
        allow(ref1).to receive(:visited).and_return(true)
        allow(ref1).to receive(:successful).and_return(true)
        allow(ref2).to receive(:visited).and_return(true)
        allow(ref2).to receive(:successful).and_return(true)
        allow(ref3).to receive(:visited).and_return(true)
        allow(ref3).to receive(:successful).and_return(false)

        expect(sender_multi_refs.sent_referral_count).to eq(3)
        expect(sender_multi_refs.total_reward_point).to eq(2)
      end
      it 'knows self referrals does not count toward total reward point' do
        sender_self_ref = User.create(name: 'Self Referrer', email: 'sr@email.com')
        sender_self_ref.sent_referrals.create(to_user: sender, referral_token: 'self_referrer')
        expect(sender_self_ref.sent_referral_count).to eq(1)
        expect(sender_self_ref.total_reward_point).to eq(0)
      end
    end
  end

  describe 'activity_feed' do
    context 'no referral sent yet' do
      specify { expect(sender_no_ref.activity_feeds.count).to eq(0)}
    end

    context 'one referral sent' do
      specify { expect(sender.activity_feeds.count).to eq(1)}
    end

    context 'the view requires three latest feeds for display' do

      # rightmost element gets evaluated first, so in sent_referrals, ref4 will be
      # the oldest referral and ref1 will be the most recent referral
      let(:sender_multi_refs) { FactoryBot.build_stubbed(:user, sent_referrals: [ref1, ref2, ref3, ref4] ) }
      let(:recipient4) { FactoryBot.build_stubbed(:user, name: 'Emily F', email: 'ef@mail.com') }
      let(:ref4) {FactoryBot.build_stubbed(:referral, to_user: recipient4, referral_token: '4') }

      it 'retrieves the three latest feeds' do
        feeds = sender_multi_refs.three_latest_feeds
        expect(feeds.count).to eq(3)
        expect(feeds.include? ref1.to_activity_feed).to be true
        expect(feeds.include? ref2.to_activity_feed).to be true
        expect(feeds.include? ref3.to_activity_feed).to be true
        expect(feeds.include? ref4.to_activity_feed).to be false
      end
    end
  end

end
