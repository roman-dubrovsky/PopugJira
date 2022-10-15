class CreatedLogEvent < BaseEvent
  attr_reader :log

  def initialize(log)
    @log = log.reload
  end

  private

  def event_data
    {
      uid: log.public_id,
      task: log.task.uid,
      actor: log.actor&.uid,
      owner: log.owner.uid,
      event: log.event,
    }
  end

  def event_name
    "TaskLogCreated"
  end

  def topic
    "task_logs-stream"
  end
end