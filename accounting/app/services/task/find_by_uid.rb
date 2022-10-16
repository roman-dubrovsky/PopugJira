class Task::FindByUid
  include Callable

  attr_reader :uid

  def initialize(uid)
    @uid = uid
  end

  def call
    task = Task.find_by(uid: uid) || Task.new(uid: uid)
    Task::VerifyPrices.call(task)
  end
end