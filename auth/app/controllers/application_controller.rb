class ApplicationController < ActionController::Base
  before_action :authenticate_account!

  def index
  end
end
