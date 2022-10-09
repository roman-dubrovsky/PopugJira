class AccountUpdatedEvent < AccountCudEvent
  private

  def event_name
    "AccountUpdated"
  end
end