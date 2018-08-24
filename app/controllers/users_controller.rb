class UsersController < ApplicationController
  include SessionsHelper
  before_action :current_user, only: :index
  before_action :redirect_if_logged_in, only: [:new, :create]

  def index
    redirect_to login_path, notice: "ログインしてください。" and return unless logged_in?
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    decorator = SavingUserWithSendingMail.new(@user)

    if decorator.save
      redirect_to users_path, notice: '登録完了メールを送信しました。'
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
