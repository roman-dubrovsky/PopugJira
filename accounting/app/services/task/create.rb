# frozen_string_literal: true

module Task
  class Create
    include Callable

    attr_reader :uid, :title

    def initialize(uid:, title:)
      @uid = uid
      @title = title
    end

    def call
      Task::VerifyPrices.call(task)
      task.title = title
      task.save
    end

    private

    def task
      @_task ||= Task.find_or_initialize_by(uid: uid)
    end
  end
end
