# frozen_string_literal: true

class Payment
  attr_reader :account, :income

  def initialize(account, income)
    @account = account
    @income = income
  end

  def call_async
    if success?
      Rails.logger.info "Payment #{income.format} for #{account.display_name} success!!"
    else
      Rails.logger.info "Payment for #{account.display_name} failed!!"
      refund_balance = Balance.create(
        account: account,
        billing_cycle: BillingCycle.active,
        credit: income,
        title: "Refund income",
        source: :debt
      )
      CreatedBalanceEvent.call(refund_balance.reload)
    end
  end

  private

  def success?
    rand(1..10) > 2
  end
end
