# frozen_string_literal: true

module BillingCycle
  class Finish
    include Callable

    def initialize
      @payments = []
    end

    def call
      BillingCycle.transaction do
        billing_cycle.update(active: false)
        new_billing_cycle = BillingCycle.active

        Account.galera_employee.find_each do |account|
          credit = Money.new(account.balances.where(billing_cycle: billing_cycle).sum(:credit_cents))
          debit = Money.new(account.balances.where(billing_cycle: billing_cycle).sum(:debit_cents))
          income = credit - debit

          SummaryMailer.call(account: account, billing_cycle: billing_cycle, income: income)

          if income.positive?
            process_payment(account, income)
          elsif income.negative?
            income *= -1
            process_debt(account, income, new_billing_cycle)
          end
        end
      end

      # Simulate running payments in BJ
      @payments.each do |account, income|
        Payment.new(account, income).call_async
      end
    end

    private

    def process_payment(account, income)
      payment_balance = Balance.create(
        account: account,
        billing_cycle: billing_cycle,
        debit: income,
        title: "Pay income",
        source: :accounting
      )
      CreatedBalanceEvent.call(payment_balance.reload)
      @payments << [account, income]
    end

    def process_debt(account, income, new_billing_cycle)
      close_dept_balance = Balance.create(
        account: account,
        billing_cycle: billing_cycle,
        credit: income,
        title: "Close billing cycle",
        source: :accounting
      )
      move_dept_balance = Balance.create(
        account: account,
        billing_cycle: new_billing_cycle,
        debit: income,
        title: "Debt from previous billing cycle",
        source: :debt
      )
      CreatedBalanceEvent.call(close_dept_balance.reload)
      CreatedBalanceEvent.call(move_dept_balance.reload)
    end

    def billing_cycle
      @_billing_cycle ||= BillingCycle.active
    end
  end
end
