class BaseEvent
  include Callable

  def call
    result = SchemaRegistry.validate_event(event, event_schema, version: event_version)

    if result.success?
      Karafka.producer.produce_sync(topic: topic, payload: event.to_json)
    else
      Rails.logger.info "*" * 100
      Rails.logger.info "Event error: #{event_name}"
      Rails.logger.info result.result
      Rails.logger.info "*" * 100
    end
  end

  def event
    @_event ||= {
      event_id: SecureRandom.uuid,
      event_version: event_version,
      event_name: event_name,
      event_time: Time.zone.now.to_s,
      producer: "task_tracker_service",
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
    raise "Not Implemented"
  end

  def event_schema
    raise "Not Implemented"
  end
end
