class BillingCycle::DataForDashboard
  attr_reader :billing_cycle, :account_id

  def initialize(billing_cycle:, account_id:)
    @billing_cycle = billing_cycle
    @account_id = account_id
  end

  def credit
    @_credit ||= Money.new(task_balances.sum(:credit_cents))
  end

  def debit
    @_debit ||= Money.new(task_balances.sum(:debit_cents))
  end

  def income
    debit - credit
  end

  def accounts_info
    accounts.map do |account|
      BillingCycle::ShortAccountDataForDashboard.new(billing_cycle: billing_cycle, account: account)
    end
  end

  def previous_cycle
    return @previous_cycle if defined? @previous_cycle
    @previous_cycle = BillingCycle.where("created_at < ?", billing_cycle.created_at).order(created_at: :desc).first
  end

  def next_cycle
    return @next_cycle if defined? @next_cycle
    @next_cycle = BillingCycle.where("created_at > ?", billing_cycle.created_at).order(created_at: :asc).first
  end

  private

  def task_balances
    billing_cycle.balances.where(source: :task)
  end

  def accounts
    scope = Account.galera_employee
    scope.where(id: account_id) if account_id.present?
    scope
  end
end