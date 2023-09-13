class Practice < ApplicationRecord
  belongs_to :user
  belongs_to :focus, optional: true
  belongs_to :song, optional: true
  validates :minutes, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :practice_date, presence: true #, timeliness: { type: :date }
  validates :user, presence: true
  validates :notes, length: { maximum: 1000 }

  # TODO: are these getting used?
  scope :this_week, -> { where(practice_date: 1.week.ago.beginning_of_day..Time.now.end_of_day) }

  # given a date, return practices for that date's month and year
  scope :this_month, ->(date) { where(practice_date: date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day) }

  # get all practices for this week, grouped by day, and sum the minutes for each day
  scope :this_week_grouped, -> { this_week.select("to_char(DATE(practice_date), 'Day')").group("to_char(DATE(practice_date), 'Day')").sum(:minutes) }
  # get total sum of minutes for this week
  scope :this_week_total, -> { this_week.sum(:minutes) }

  # get all practicds grouped by practice date without time, and sum the minutes for each day
  scope :grouped_by_day, -> { select("DATE(practice_date)").group("DATE(practice_date)").sum(:minutes) }

  # get earliest practice_date
  scope :first_practice_date, -> { order(:practice_date).first.practice_date }

  scope :in_week, ->(date) { where(practice_date: date.beginning_of_week.beginning_of_day..date.end_of_week.end_of_day) }

  scope :on_date, ->(date) { where(practice_date: date.beginning_of_day..date.end_of_day) }

    # loop from the begnning of date's month to the end of date's month
    # for each day, if the day is not in the practices hash, add it with 0 minutes
    # if the day is in the practices hash, do nothing
    # return the practices hash
    def self.fill_in_missing_days(practices, date)
    (date.beginning_of_month..date.end_of_month).each do |day|
      logger.debug(day.strftime("%a, %d %b %Y"))
      current_day = day.strftime("%a, %d %b %Y")
      practices[day] = 0 unless practices.key?(day)
    end
    practices
  end

  def show_timer?
    new_record?
  end

end
