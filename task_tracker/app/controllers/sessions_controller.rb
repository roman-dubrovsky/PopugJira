class SessionsController < ApplicationController
  skip_before_action :authenticate_account!

  def new
  end

  def create
    user_info = request.env['omniauth.auth']
    result = Account::FindOrCreate.call(uid: user_info.uid, params: user_info.info.to_h)
    if result.success?
      session[:account] = result.account.uid
      redirect_to root_path
    else
      render plain: "Ups"
    end
  end

  def destroy
    session[:account] = nil
    redirect_to root_path
  end
end