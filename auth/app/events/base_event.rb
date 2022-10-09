class BaseEvent
  def to_json
    {
      event_name: self.class.event_name,
      data: event_data,
    }.to_json
  end

  private

  def event_data
    raise "Not Implemented"
  end

  def self.event_name
    raise "Not Implemented"
  end
end