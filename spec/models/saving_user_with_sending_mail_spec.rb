require 'rails_helper'

RSpec.describe SavingUserWithSendingMail, type: :model do
  describe "#save" do
    let(:user) { instance_double(User, save: result) }

    context "保存に成功した場合" do
      let(:result) { true }
      let(:decorator) { SavingUserWithSendingMail.new(user) }
      let(:message_delivery) { instance_double(ActionMailer::MessageDelivery, deliver_now: true) }

      it do
        expect(UserMailer).to receive(:new_user).with(user) { message_delivery }
        expect(decorator.save).to be_truthy
      end
    end

    context "保存に失敗した場合" do
      let(:result) { false }
      let(:decorator) { SavingUserWithSendingMail.new(user) }

      it do
        expect(UserMailer).not_to receive(:new_user)
        expect(decorator.save).to be_falsey
      end
    end
  end
end
