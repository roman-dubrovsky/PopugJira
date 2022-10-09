class AccountRoleChangedEvent < BaseEvent
  attr_reader :account

  def initialize(account)
    @account = account
  end

  private

  def event_data
    {
      public_id: account.public_id,
      role: account.role,
    }
  end

  def event_name
    "AccountRoleChanged"
  end

  def topic
    "accounts"
  end
end