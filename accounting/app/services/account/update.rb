class Account::Update
  include Callable

  attr_reader :uid, :params

  def initialize(uid:, params:)
    @uid = uid
    @params = params
  end

  def call
    account = Account::FindByUid.call(uid)
    account.update(params)
    return account
  end
end