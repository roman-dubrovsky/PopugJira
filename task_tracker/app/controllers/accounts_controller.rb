class AccountsController < ApplicationController
  before_action :autorize_admin!

  def index
    @accounts = Account.employees
  end
end