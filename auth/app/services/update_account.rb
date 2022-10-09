class UpdateAccount
  include Callable

  Result = Struct.new(:success?, :account)

  attr_reader :account, :params, :new_role

  def initialize(account:, params:)
    @account = account
    @params = params
    @new_role = params[:role] != account.role ? params[:role] : nil
  end

  def call
    if account.update(params)
      AccountUpdatedEvent.call(account)

      if new_role.present?
        AccountRoleChangedEvent.call(account)
      end

      Result.new(true, account)
    else
      Result.new(false, account)
    end
  end
end