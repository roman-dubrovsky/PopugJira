class Account::FindOrCreate
  include Callable

  Result = Struct.new(:success?, :account)

  attr_reader :uid, :params

  def initialize(uid:, params:)
    @uid = uid
    @params = params
  end

  def call
    return Result.new(true, existing_account) if existing_account.present?

    account = Account.new(user_params)
    if account.save
      Result.new(true, account)
    else
      Result.new(false, account)
    end
  end

  private

  def existing_account
    @_existing_account ||= Account.find_by(uid: uid)
  end

  def user_params
    {
      uid: uid,
      email: params["email"],
      position: params["position"],
      full_name: params["full_name"],
      role: params["role"]
    }
  end
end