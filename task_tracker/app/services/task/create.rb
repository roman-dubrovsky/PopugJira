class Task::Create
  include Callable

  TITLE_REGEXP = /^\[(.+)\] (- )?(.+)$/.freeze

  Result = Struct.new(:success?, :task)

  attr_reader :account, :params

  def initialize(account:, params:)
    @account = account
    @params = params
  end

  def call
    @task = Task.new(deserialized_params)
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

  def deserialized_params
    title = params[:title]

    matches = title.match TITLE_REGEXP

    if matches.present?
      params.merge(
        title: matches[3],
        jira_id: matches[1]
      )
    else
      params
    end
  end

  def employee
    @_employee ||= begin
      count = Account.employees.count
      Account.employees.offset(rand(count)).first
    end
  end
end
