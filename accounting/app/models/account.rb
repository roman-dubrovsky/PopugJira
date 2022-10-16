class Account < ApplicationRecord
  validates :uid, presence: true

  has_many :balances

  def display_name
    full_name || email || uid
  end
end
