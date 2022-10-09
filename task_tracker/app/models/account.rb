class Account < ApplicationRecord
  def display_name
    full_name || email
  end
end
