class UserMailer < ApplicationMailer
  def new_user(user)
    @user = user
    mail to: "to@example.org"
  end
end
