class Balance < ApplicationRecord
  belongs_to :account
  belongs_to :billing_cycle

  monetize :credit_cents
  monetize :debit_cents

  def additional_data
    metadata.present? ? JSON.parse(metadata) : {}
  end
end
