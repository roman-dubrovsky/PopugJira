class Transaction::Migrate
  def call
    Balance.find_each do |balance|
      if balance.source.task?
        task_id = balance.additional_data["task_id"]
        task = Task.find_by(uid: task_id)

        transaction = Transaction.create(
          account: balance.account,
          billing_cycle: balance.billing_cycle,
          task: task,
          debit: task.assign_price,
          kind: balance.credit.zero? ? :assign_task : :complete_task
        )

        if transaction.kind.assign_task?
          Transaction::AssignedAccountEvent.call(transaction.reload)
        else
          Transaction::CompletedTaskEvent.call(transaction.reload)
        end
      end
    end
  end
end
