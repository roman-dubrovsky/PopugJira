# frozen_string_literal: true

module BillingCycle
  class AccountDataForDashboard < BillingCycle::ShortAccountDataForDashboard
    BalanceData = Struct.new(:title, :credit, :debit)

    def previous_cycle
      return @previous_cycle if defined? @previous_cycle

      @previous_cycle = BillingCycle.where("created_at < ?", billing_cycle.created_at).order(created_at: :desc).first
    end

    def next_cycle
      return @next_cycle if defined? @next_cycle

      @next_cycle = BillingCycle.where("created_at > ?", billing_cycle.created_at).order(created_at: :asc).first
    end

    def balances_data
      @_balances_data ||= balances.order(created_at: :asc).map do |balance|
        BalanceData.new(balance.title, balance.credit, balance.debit)
      end
    end

    def current_balance
      Money.new(balances.sum(:credit_cents)) - Money.new(balances.sum(:debit_cents))
    end
  end
end
