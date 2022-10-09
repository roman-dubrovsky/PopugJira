class ApplicationController < ActionController::Base
  helper_method :current_account

  def index
  end

  private

  def current_account
    @_current_account = Account.find_by(uid: session[:account])
  end
end
