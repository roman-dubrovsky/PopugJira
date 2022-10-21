# frozen_string_literal: true

class BillingCycle::ShortAccountDataForDashboard
  attr_reader :billing_cycle, :account

  def initialize(billing_cycle:, account:)
    @billing_cycle = billing_cycle
    @account = account
  end

  def income
    @_income ||= credit - debit
  end

  def credit
    @_credit ||= Money.new(task_balances.sum(:credit_cents))
  end

  def debit
    @_debit ||= Money.new(task_balances.sum(:debit_cents))
  end

  private

  def balances
    account.balances.where(billing_cycle: billing_cycle)
  end

  def task_balances
    balances.where(source: %i[task debt])
  end
end
