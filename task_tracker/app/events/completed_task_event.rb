class CompletedTaskEvent < BaseEvent
  attr_reader :task, :log

  def initialize(task, log)
    @task = task
    @log = log
  end

  private

  def event_data
    {
      uid: task.uid,
      time: log.created_at.to_s,
    }
  end

  def event_name
    "CompletedTask"
  end

  def topic
    "tasks"
  end

  def event_version
    1
  end

  def event_schema
    'tasks.completed'
  end
end