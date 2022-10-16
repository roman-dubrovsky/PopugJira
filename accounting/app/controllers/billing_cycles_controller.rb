class BillingCyclesController < ApplicationController
  helper_method :dashboard

  def show
    @billing_cycle = BillingCycle.find(params[:id])
  end

  def current
    @billing_cycle = BillingCycle.active
    render :show
  end

  private

  def dashboard
    @_dashboard ||= BillingCycle::DataForDashboard.new(@billing_cycle)
  end
end