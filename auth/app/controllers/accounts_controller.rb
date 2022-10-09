class AccountsController < ApplicationController
  helper_method :accounts_scope, :account

  def index
  end

  def edit
  end

  def update
    UpdateAccount.call(account: account, params: account_params)
  end

  private

  def account_params
    params.require(:account).permit(:full_name, :role, :position)
  end

  def accounts_scope
    if current_account.admin?
      Account.all
    else
      Account.where(id: current_account.id)
    end
  end

  def account
    @_account ||= accounts_scope.find(params[:id])
  end
end