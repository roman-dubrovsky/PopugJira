class BillingCycle::Create
  include Callable

  def call
    cycle = BillingCycle.create(
      title: title,
      date: date,
    )
    CreatedBillingCycleEvent.call(cycle.reload)
    return cycle
  end

  private

  def title
    if cycles_for_date.zero?
      date.to_s
    else
      "#{date.to_s} - #{cycles_for_date + 1}"
    end
  end

  def cycles_for_date
    @_cycles_for_date ||= BillingCycle.where(date: date).count
  end

  def date
    @_date ||= Date.today
  end
end