class ApplicationController < ActionController::Base
  helper_method :current_account, :admin?

  before_action :authenticate_account!

  private

  def authenticate_account!
    redirect_to login_path unless current_account.present?
  end

  def autorize_admin!
    redirect_to root_path unless current_account.admin?
  end

  def current_account
    @_current_account = Account.find_by(uid: session[:account])
  end

  def admin?
    current_account.role == "admin" || current_account.role == "accounting_clerk" || current_account.role == 'manager'
  end
end
 