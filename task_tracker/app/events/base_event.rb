class BaseEvent
  include Callable

  def call
    Karafka.producer.produce_sync(topic: topic, payload: to_json)
  end

  def to_json
    {
      event_name: event_name,
      data: event_data,
    }.to_json
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
end