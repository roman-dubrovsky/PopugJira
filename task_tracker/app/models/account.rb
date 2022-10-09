class Account < ApplicationRecord
  has_many :assigned_tasks, -> { where(active: true) }, class_name: "Task", foreign_key: 'owner_id'
  has_many :finished_tasks, -> { where(active: false) }, class_name: "Task", foreign_key: "owner_id"

  has_many :tasks, class_name: "Task", foreign_key: 'owner_id'

  scope :employees, -> { where.not(role: ["admin", 'manager']).or(where(role: nil)) }

  def display_name
    full_name || email
  end

  def admin?
    role == 'admin' || role == 'manager'
  end
end
