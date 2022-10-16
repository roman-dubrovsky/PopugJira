# Popugs don't use mails and read logs instead
class SummaryMailer
  include Callable

  attr_reader :account, :billing_cycle, :income

  def initialize(account:, billing_cycle:, income:)
    @account = account
    @billing_cycle = billing_cycle
    @income = income
  end

  def call
    Rails.logger.info "**** Summary about #{account.display_name} balance for #{billing_cycle.title} ****"
    Rails.logger.info "Income: #{income.format}"
  end
end