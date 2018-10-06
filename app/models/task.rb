class Task < ApplicationRecord
  belongs_to :user
  validates :taskname, presence: true, length: { minimum: 3, maximum: 20 }
  validates :importance, presence: true
  validates :category, presence: true
end
