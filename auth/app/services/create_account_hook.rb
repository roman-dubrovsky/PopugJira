class CreateAccountHook
  include Callable
  
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def call
    AccountCreatedEvent.call(account)
  end
end