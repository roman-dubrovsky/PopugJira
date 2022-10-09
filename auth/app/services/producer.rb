class Producer
  include Callable
  attr_reader :event, :topic

  def initialize(event, topic)
    @event = event
    @topic = topic
  end

  def call
    Rails.logger.info "Producing event to topic #{topic}"
    Rails.logger.info event.to_json
  end
end