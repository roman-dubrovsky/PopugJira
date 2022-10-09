class AccountCreatedEvent < BaseEvent
  attr_reader :account

  def initialize(account)
    @account = account
  end

  private

  def event_data
    {
      public_id: account.id,
      email: account.email
    }
  end

  def self.event_name
    "AccountCreated"
  end
end