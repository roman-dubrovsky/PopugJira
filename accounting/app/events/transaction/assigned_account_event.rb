class Transaction::AssignedAccountEvent < Transaction::BaseEvent
  attr_reader :account

  private

  def event_data
    super.merge(
      debit_cents: transaction.debit_cents,
      task_id: transaction.task.uid
    )
  end

  def event_version
    1
  end

  def event_schema
    "transactions.assigned_account"
  end

  def event_name
    "TransactionAccountAssigned"
  end
end
