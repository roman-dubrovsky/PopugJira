# frozen_string_literal: true

class Task::AssignOwner
  include Callable

  attr_reader :task_id, :account_id

  def initialize(task_id:, account_id:)
    @task_id = task_id
    @account_id = account_id
  end

  def call
    Transaction.transaction do
      task.update(owner: account)

      transaction = Transaction.create(
        account: account,
        billing_cycle: BillingCycle.active,
        task: task,
        debit: task.assign_price,
        kind: :assign_task
      )
      Transaction::AssignedAccountEvent.call(transaction.reload)
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
