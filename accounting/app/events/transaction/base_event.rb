# frozen_string_literal: true

class Transaction::BaseEvent < BaseEvent
  attr_reader :transaction

  def initialize(transaction)
    @transaction = transaction
  end

  private

  def event_data
    {
      public_id: transaction.uid,
      title: "Test",
      time: transaction.created_at.to_s,
      account_id: transaction.account.uid,
      billing_cycle_id: transaction.billing_cycle.uid,
    }
  end

  def topic
    "transactions"
  end
end
