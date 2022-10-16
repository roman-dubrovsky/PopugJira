class BaseEvent
  include Callable

  def call
    result = SchemaRegistry.validate_event(event, event_schema, version: event_version)

    if result.success?
      WaterDrop::SyncProducer.call(event.to_json, topic: topic)
    else
      byebug
    end
  end

  def event
    @_event ||= {
      event_id: SecureRandom.uuid,
      event_version: event_version,
      event_name: event_name,
      event_time: Time.now.to_s,
      producer: 'auth_service',
      data: event_data,
    }
  end

  private

  def event_data
    raise "Not Implemented"
  end

  def event_name
    raise "Not Implemented"
  end

  def topic
    raise "Not Implemented"
  end

  def event_version
    raise 'Not Implemented'
  end

  def event_schema
    raise 'Not Implemented'
  end
end