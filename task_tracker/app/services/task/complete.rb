class Task::Complete
  include Callable

  attr_reader :account, :task

  def initialize(account:, task:)
    @account = account
    @task = task
  end

  def call
    task.update(active: false)
    log = task.task_state_logs.create(actor: account, owner: task.owner, event: "Task Completed")
    CompletedTaskEvent.call(task, log)
    CreatedLogEvent.call(log)
  end
end