class Task::Shuffle
  include Callable

  attr_reader :account

  def initialize(account:)
    @account = account
  end

  def call
    tasks.find_each do |task|
      employee = random_employee
      task.update(owner: employee)
      log = task.task_state_logs.create(actor: account, owner: employee, event: "Task Assigned")
      AssignedTaskEvent.call(task, log)
      CreatedLogEvent.call(log)
    end
  end

  private

  def tasks
    Task.where(active: true)
  end

  def random_employee
    count = Account.employees.count
    Account.employees.offset(rand(count)).first
  end
end
