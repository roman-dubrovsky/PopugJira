class CreatedBillingCycleEvent < BaseEvent
  attr_reader :billing_cycle

  def initialize(billing_cycle)
    @billing_cycle = billing_cycle
  end

  private

  def event_data
    {
      public_id: billing_cycle.uid,
      title: billing_cycle.title,
      date: billing_cycle.date.to_s,
    }
  end

  def event_name
    "BillingCycleCreated"
  end

  def topic
    "billing_cycles-stream"
  end

  def event_version
    1
  end

  def event_schema
    'billing_cycles.created'
  end
end