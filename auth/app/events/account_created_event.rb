class AccountCreatedEvent < AccountCudEvent
  private

  def event_name
    "AccountCreated"
  end

  def event_version
    1
  end

  def event_schema
    'accounts.created'
  end
end