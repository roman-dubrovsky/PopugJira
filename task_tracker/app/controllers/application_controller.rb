class ApplicationController < ActionController::Base
  helper_method :current_account

  before_action :authenticate_account!

  def index
  end

  private

  def authenticate_account!
    redirect_to login_path if current_account.blank?
  end

  def autorize_admin!
    redirect_to root_path unless current_account.admin?
  end

  def current_account
    @_current_account = Account.find_by(uid: session[:account])
  end
end
