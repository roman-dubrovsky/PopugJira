class AccountUpdatedEvent < AccountCudEvent
  private

  def event_name
    "AccountUpdated"
  end

  def event_version
    1
  end

  def event_schema
    "accounts.updated"
  end
end
