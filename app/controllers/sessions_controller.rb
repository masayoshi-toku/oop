class SessionsController < ApplicationController
  include SessionsHelper
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: login_params[:email])

    if @user&.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインに成功しました。"
      redirect_to users_path
    else
      flash.now[:notice] = "無効なメールアドレスまたはパスワードです。"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました。"
  end

  private

    def login_params
      params.require(:session).permit(:email, :password)
    end
end
