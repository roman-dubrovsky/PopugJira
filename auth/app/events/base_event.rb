class BaseEvent
  include Callable

  def call
    Producer.call(to_json, topic: topic)
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