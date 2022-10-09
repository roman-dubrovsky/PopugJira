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
      update_event = AccountUpdatedEvent.new(account)
      Producer.call(update_event, topic: "accounts-stream")

      if new_role.present?
        role_event = AccountRoleChangedEvent.new(account)
        Producer.call(role_event, topic: "accounts")
      end

      Result.new(true, account)
    else
      Result.new(false, account)
    end
  end
end