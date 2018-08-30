module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_if_logged_in
    redirect_to users_path, notice: "既にログイン済みです。" if logged_in?
    return
  end
end
