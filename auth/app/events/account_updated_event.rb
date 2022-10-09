class AccountUpdatedEvent < AccountCudEvent
  private

  def self.event_name
    "AccountUpdated"
  end
end