class SessionsController < ApplicationController
  skip_before_action :authenticate_account!

  def new
  end

  def create
    user_info = request.env['omniauth.auth']
    account = Account::Update.call(
      uid: user_info.uid,
      params: user_info.info.to_h.slice('email', 'full_name', 'position', 'role')
    )

    session[:account] = account.uid
    redirect_to root_path
  end

  def destroy
    session[:account] = nil
    redirect_to root_path
  end
end