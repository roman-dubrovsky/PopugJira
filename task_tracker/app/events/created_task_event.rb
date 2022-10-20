class CreatedTaskEvent < BaseEvent
  attr_reader :task

  def initialize(task)
    @task = task
  end

  private

  def event_data
    {
      public_id: task.uid,
      title: task.title,
      jira_id: task.jira_id,
    }
  end

  def event_name
    "TaskCreated"
  end

  def topic
    "tasks-stream"
  end

  def event_version
    3
  end

  def event_schema
    "tasks.created"
  end
end
