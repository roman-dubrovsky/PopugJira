class AccountChanges < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload
      case [payload["event_name"], payload["event_version"]]
      when ["AccountCreated", 1]
        next if Account.find_by(uid: payload["data"]["public_id"]).present?

        Account.create(
          uid: payload["data"]["public_id"],
          email: payload["data"]["email"],
          full_name: payload["data"]["full_name"],
          position: payload["data"]["position"]
        )
      when ["AccountUpdated", 1]
        account = Account.find_by(uid: payload["data"]["public_id"])
        next if account.nil?

        account.update(payload["data"].slice("email", "full_name", "position"))
      when ["AccountRoleChanged", 1]
        account = Account.find_by(uid: payload["data"]["public_id"])
        next if account.nil?

        account.update(role: payload["data"]["role"])
      end
    end
  end
end
