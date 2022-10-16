class Task::VerifyPrices
  include Callable

  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    return task if !task.assign_price.zero? && !task.complete_price.zero?

    task.title ||= "Undefined"
    task.assign_price_cents = generate_assign_price if task.assign_price.zero?
    task.complete_price_cents = generate_complete_price if task.complete_price.zero?
    task.save
    task
  end

  private

  def generate_assign_price
    rand(10..20)
  end

  def generate_complete_price
    rand(20..40)
  end
end