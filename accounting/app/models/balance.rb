class Balance < ApplicationRecord
  extend Enumerize

  belongs_to :account
  belongs_to :billing_cycle

  monetize :credit_cents
  monetize :debit_cents

  enumerize :source, in: [:task]

  def additional_data
    metadata.present? ? JSON.parse(metadata) : {}
  end
end
