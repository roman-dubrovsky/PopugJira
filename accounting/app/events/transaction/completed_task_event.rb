class Transaction::CompletedTaskEvent < Transaction::BaseEvent
  attr_reader :account

  private

  def event_data
    super.merge(
      credit_cents: transaction.credit_cents,
      task_id: transaction.task.uid
    )
  end

  def event_version
    1
  end

  def event_schema
    "transactions.completed_task"
  end

  def event_name
    "TransactionTaskCompleted"
  end
end
