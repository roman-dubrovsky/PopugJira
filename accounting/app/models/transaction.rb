class Transaction < ApplicationRecord
  extend Enumerize

  belongs_to :account
  belongs_to :billing_cycle
  belongs_to :task, optional: true

  monetize :credit_cents
  monetize :debit_cents

  enumerize :kind, in: %i[assign_task complete_task]

  def title
    @_title = Transaction::GenerateTitle.call(self)
  end
end
