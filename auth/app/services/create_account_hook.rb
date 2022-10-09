class CreateAccountHook
  include Callable
  
  attr_reader :account

	def initialize(account)
    @account = account
  end

  def call
    event = AccountCreatedEvent.new(account)
    Producer.call(event, topic: "accounts-stream")
  end
end