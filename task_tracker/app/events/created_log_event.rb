class CreatedLogEvent < BaseEvent
  attr_reader :log

  def initialize(log)
    @log = log.reload
  end

  private

  def event_data
    {
      public_id: log.public_id,
      task_id: log.task.uid,
      actor_id: log.actor&.uid,
      owner_id: log.owner.uid,
      event: log.event,
      time: log.created_at.to_s,
    }
  end

  def event_name
    "TaskLogCreated"
  end

  def topic
    "task_logs-stream"
  end

  def event_version
    2
  end

  def event_schema
    'task_logs.created'
  end
end