# frozen_string_literal: true

class AccountsController < ApplicationController
  def show
    @billing_cycle = BillingCycle.find(params[:billing_cycle_id])
    @account = Account.find(params[:id])
    @dashboard = BillingCycle::AccountDataForDashboard.new(billing_cycle: @billing_cycle, account: @account)
  end
end
