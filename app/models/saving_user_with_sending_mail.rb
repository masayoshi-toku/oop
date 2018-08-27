class SavingUserWithSendingMail
  include ActiveModel::Model
  define_model_callbacks :save, only: :after
  after_save :send_mail

  def initialize(user)
    @user = user
  end

  def save
    run_callbacks :save do
      @user.save
    end
  end

  private

    def send_mail
      UserMailer.new_user(@user).deliver_now
    end
end
