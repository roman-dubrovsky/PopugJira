class AccountCreatedEvent < AccountCudEvent
  private

  def event_name
    "AccountCreated"
  end
end