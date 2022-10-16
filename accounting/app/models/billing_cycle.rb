class BillingCycle < ApplicationRecord
  validates :title, :date, presence: true

  def self.active
    find_by(active: true) || BillingCycle::Create.call
  end
end
