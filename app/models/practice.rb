class Practice < ApplicationRecord
  belongs_to :user
  belongs_to :focus, optional: true
  validates :minutes, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :practice_date, presence: true #, timeliness: { type: :date }
  validates :user, presence: true
  validates :notes, length: { maximum: 1000 }

  scope :this_week, -> { where("practice_date >= ?", Date.today - 7.days) }
  # get all practices for this week, grouped by day, and sum the minutes for each day
  scope :this_week_grouped, -> { this_week.group("to_char(DATE(practice_date), 'Day')").sum(:minutes) }
  # get total sum of minutes for this week
  scope :this_week_total, -> { this_week.sum(:minutes) }
  # get earliest practice_date
  scope :first_practice_date, -> { order(:practice_date).first.practice_date }

  def show_timer?
    new_record?
  end

end
