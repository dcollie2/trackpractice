class Practice < ApplicationRecord
  belongs_to :user
  validates :minutes, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :practice_date, presence: true #, timeliness: { type: :date }
  validates :user, presence: true
  validates :notes, length: { maximum: 1000 }

  default_scope { order(practice_date: :desc) }
  scope :this_week, -> { where("practice_date >= ?", Date.today.beginning_of_week) }


end
