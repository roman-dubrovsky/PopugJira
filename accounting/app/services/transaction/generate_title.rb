class Transaction::GenerateTitle
  include Callable

  attr_reader :transaction
  delegate :task, to: :transaction

  def initialize(transaction)
    @transaction = transaction
  end

  def call
    case transaction.kind
    when "assign_task"
      "Assign task #{task.uid}"
    when "complete_task"
      "Complete task #{task.uid}"
    end
  end
end
