class TasksConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload

      case [payload['event_name'], payload['event_version']]

      when ['TaskCreated', 1]
        Task::Create.call(
          uid: payload['data']['uid'],
          title: payload['data']['title']
        )
      when ['TaskCreated', 2], ['TaskCreated', 3]
        Task::Create.call(
          uid: payload['data']['public_id'],
          title: payload['data']['title']
        )
      when ['AssignedTask', 1]
        Task::AssignOwner.call(
          task_id: payload['data']['uid'],
          account_id: payload['data']['owner'],
        )
      when ['AssignedTask', 2]
        Task::AssignOwner.call(
          task_id: payload['data']['public_id'],
          account_id: payload['data']['owner_id'],
        )
      when ['CompletedTask', 1]
        Task::Complete.call(
          task_id: payload['data']['uid'],
        )
      when ['CompletedTask', 2]
        Task::Complete.call(
          task_id: payload['data']['public_id'],
          account_id: payload['data']['owner_id'],
        )
      end
    end
  end
end