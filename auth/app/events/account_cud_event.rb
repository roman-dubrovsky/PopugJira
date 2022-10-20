class AccountCudEvent < BaseEvent
  attr_reader :account

  def initialize(account)
    @account = account
  end

  private

  def event_data
    {
      public_id: account.public_id,
      email: account.email,
      full_name: account.full_name,
      position: account.position,
    }
  end

  def topic
    "accounts-stream"
  end
end
