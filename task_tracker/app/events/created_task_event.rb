class CreatedTaskEvent < BaseEvent
  attr_reader :task

  def initialize(task)
    @task = task
  end

  private

  def event_data
    {
      uid: task.uid,
      title: task.title,
    }
  end

  def event_name
    "TaskCreated"
  end

  def topic
    "tasks-stream"
  end
end