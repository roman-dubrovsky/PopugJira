# frozen_string_literal: true

class BillingCycle < ApplicationRecord
  validates :title, :date, presence: true

  has_many :balances

  def self.active
    find_by(active: true) || BillingCycle::Create.call
  end
end
