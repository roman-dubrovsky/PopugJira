class AccountCreatedEvent < AccountCudEvent
  private

  def self.event_name
    "AccountCreated"
  end
end