# frozen_string_literal: true

class Task < ApplicationRecord
  monetize :assign_price_cents
  monetize :complete_price_cents

  validates :uid, :title, :assign_price, :complete_price, presence: true
  validates :assign_price_cents, :complete_price_cents, numericality: {
    greater_than: 0,
  }

  belongs_to :owner, class_name: "Account", optional: true
end
