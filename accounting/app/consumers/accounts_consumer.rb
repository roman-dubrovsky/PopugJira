# frozen_string_literal: true

class AccountsConsumer < ApplicationConsumer
  def consume
    messages.each do |message|
      payload = message.payload
      case [payload["event_name"], payload["event_version"]]
      when ["AccountCreated", 1], ["AccountUpdated", 1]
        Account::Update.call(
          uid: payload["data"]["public_id"],
          params: payload["data"].slice("email", "full_name", "position")
        )
      when ["AccountRoleChanged", 1]
        Account::Update.call(
          uid: payload["data"]["public_id"],
          params: {role: payload["data"]["role"]}
        )
      end
    end
  end
end
