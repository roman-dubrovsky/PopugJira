# frozen_string_literal: true

class Account::FindByUid
  include Callable

  attr_reader :uid

  def initialize(uid)
    @uid = uid
  end

  def call
    account = Account.find_by(uid: uid)
    return account if account.present?

    Account.create(uid: uid, role: :employee)
  end
end
