# frozen_string_literal: true

class Account < ApplicationRecord
  validates :uid, presence: true

  has_many :balances

  scope :galera_employee, -> { where(role: %i[employee accounting_clerk]) }

  def display_name
    full_name || email || uid
  end
end
