class AccountsController < ApplicationController
  helper_method :accounts_scope, :account

  skip_before_action :authenticate_account!, only: [:current]

  def index
  end

  # GET /accounts/current.json
  def current
    respond_to do |format|
      format.json  { render :json => current_oauth_account }
    end
  end

  def edit
  end

  def update
    result = UpdateAccount.call(account: account, params: account_params)

    if result.success?
      redirect_to accounts_path
    else
      render :edit
    end
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

  def current_oauth_account
    if doorkeeper_token
      Account.find(doorkeeper_token.resource_owner_id)
    else
      current_account
    end
  end
end