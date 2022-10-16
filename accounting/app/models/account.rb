class Account < ApplicationRecord
  validates :uid, presence: true
end
