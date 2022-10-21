# frozen_string_literal: true

class Task::AssignOwner
  include Callable

  attr_reader :task_id, :account_id

  def initialize(task_id:, account_id:)
    @task_id = task_id
    @account_id = account_id
  end

  def call
    Balance.transaction do
      task.update(owner: account)

      balance = Balance.create(
        account: account,
        billing_cycle: BillingCycle.active,
        debit: task.assign_price,
        title: title,
        source: :task,
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
    "Assign task #{task.uid} - #{task.title}"
  end
end
