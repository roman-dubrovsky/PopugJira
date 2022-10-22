# frozen_string_literal: true

class Task::Complete
  include Callable

  attr_reader :task_id, :account_id

  def initialize(task_id:, account_id: nil)
    @task_id = task_id
    @account_id = account_id || task.owner&.uid
  end

  def call
    raise "Couldn't complete task w/o owner" if account_id.blank?

    Transaction.transaction do
      transaction = Transaction.create(
        account: account,
        billing_cycle: BillingCycle.active,
        task: task,
        credit: task.complete_price,
        kind: :complete_task
      )
      Transaction::CompletedTaskEvent.call(transaction.reload)
    end
  end

  private

  def task
    @_task ||= Task::FindByUid.call(task_id)
  end

  def account
    @_account ||= Account::FindByUid.call(account_id)
  end
end
