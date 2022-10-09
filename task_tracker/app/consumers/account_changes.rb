class AccountChanges < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload
      case payload['event_name']
      when 'AccountCreated'
        return if Account.find_by(uid: payload['data']["public_id"]).present?
        Account.create(
          uid: payload['data']["public_id"],
          email: payload['data']['email'],
          full_name: payload['data']['full_name'],
          position: payload['data']['position']
        )
      when 'AccountUpdated'
        account = Account.find_by(uid: payload['data']["public_id"])
        return if account.nil?
        account.update(payload['data'].slice('email', 'full_name', 'position'))
      when 'AccountRoleChanged'
        account = Account.find_by(uid: payload['data']["public_id"])
        return if account.nil?
        account.update(role: payload['data']['role'])
      end
    end
  end
end