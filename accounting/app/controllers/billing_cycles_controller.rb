# frozen_string_literal: true

class BillingCyclesController < ApplicationController
  helper_method :dashboard

  def show
    @billing_cycle = BillingCycle.find(params[:id])
  end

  def current
    @billing_cycle = BillingCycle.active
    render :show
  end

  def finish
    BillingCycle::Finish.call
    redirect_to root_path
  end

  private

  def dashboard
    @_dashboard ||= BillingCycle::DataForDashboard.new(
      billing_cycle: @billing_cycle,
      account_id: admin? ? nil : current_account.id
    )
  end
end
