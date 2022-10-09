class Task < ApplicationRecord
  belongs_to :creator, class_name: "Account"
  belongs_to :owner, class_name: "Account"

  has_many :task_state_logs, dependent: :destroy

  validates :title, :creator, :owner, presence: true
end
