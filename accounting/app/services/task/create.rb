class Task::Create
  include Callable

  attr_reader :uid, :title

  def initialize(uid:, title:)
    @uid = uid
    @title = title
  end

  def call
    task.title = title
    Task::VerifyPrices.call(task)
    task.save
  end

  private

  def task 
    @_task ||= Task.find_or_initialize_by(uid: uid)
  end
end