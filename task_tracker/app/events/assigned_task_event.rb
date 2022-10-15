class AssignedTaskEvent < BaseEvent
  attr_reader :task, :log

  def initialize(task, log)
    @task = task
    @log = log
  end

  private

  def event_data
    {
      uid: task.uid,
      owner: task.owner.uid,
      time: log.created_at.to_s,
    }
  end

  def event_name
    "AssignedTask"
  end

  def topic
    "tasks"
  end

  def event_version
    1
  end

  def event_schema
    'tasks.assigned'
  end
end