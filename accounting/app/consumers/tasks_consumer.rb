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
      end
    end
  end
end