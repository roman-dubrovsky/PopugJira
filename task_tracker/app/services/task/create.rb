class Task::Create
  include Callable

  Result = Struct.new(:success?, :task)

  attr_reader :account, :params

  def initialize(account:, params:)
    @account = account
    @params = params
  end

  def call
    @task = Task.new(params)
    @task.creator = account
    @task.owner = employee

    if @task.save
      log = @task.task_state_logs.create(actor: account, owner: employee, event: "Task Created and Assigned")
      @task.reload
      CreatedTaskEvent.call(@task)
      AssignedTaskEvent.call(@task, log)
      CreatedLogEvent.call(log)
      Result.new(true, @task)
    else
      Result.new(false, @task)
    end
  end

  private

  def employee
    @_employee ||= begin
      count = Account.employees.count
      Account.employees.offset(rand(count)).first
    end
  end
end