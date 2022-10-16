class Task::Complete
  include Callable

  attr_reader :task_id, :account_id

  def initialize(task_id:, account_id: nil)
    @task_id = task_id
    @account_id = account_id || task.owner&.uid
  end

  def call
    raise "Couldn't complete task w/o owner" unless account_id.present?
    
    Balance.transaction do
      balance = Balance.create(
        account: account,
        billing_cycle: BillingCycle.active,
        credit: task.complete_price,
        title: title,
        metadata: {task_id: task.uid}.to_json
      )
      CreatedBalanceEvent.call(balance.reload)
    end
  end

  private

  def task 
    @_task ||= Task::FindByUid.call(task_id)
  end

  def account 
    @_account ||= Account::FindByUid.call(account_id)
  end

  def title
    "Complete task #{task.uid} - #{task.title}"
  end
end