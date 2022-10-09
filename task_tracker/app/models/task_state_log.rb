class TaskStateLog < ApplicationRecord
  belongs_to :task
  belongs_to :actor, class_name: "Account"
  belongs_to :owner, class_name: "Account"
end
