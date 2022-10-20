# frozen_string_literal: true

class CreatedBalanceEvent < BaseEvent
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  private

  def event_data
    {
      public_id: balance.uid,
      title: balance.title,
      time: balance.created_at.to_s,
      account_id: balance.account.uid,
      billing_cycle_id: balance.billing_cycle.uid,
      debit_cents: balance.debit_cents,
      credit_cents: balance.credit_cents,
      task_id: balance.additional_data["task_id"],
    }
  end

  def event_name
    "BalanceCreated"
  end

  def topic
    "balances-stream"
  end

  def event_version
    1
  end

  def event_schema
    "balances.created"
  end
end
