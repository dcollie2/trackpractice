# frozen_string_literal: true

class Practice < ApplicationRecord
  belongs_to :user
  belongs_to :focus, optional: true
  belongs_to :song, optional: true
  belongs_to :streak_began, class_name: 'Practice', optional: true

  after_create :set_streak_beginning!

  validates :minutes, presence: true, numericality: { greater_than: 0 }
  validates :practice_date, presence: true # , timeliness: { type: :date }
  validates :user, presence: true
  validates :notes, length: { maximum: 1000 }

  # TODO: are these getting used?
  scope :this_week, -> { where(practice_date: 1.week.ago.beginning_of_day..Time.now.end_of_day) }

  # given a date, return practices for that date's month and year
  scope :this_month, lambda { |date|
                       where(practice_date: date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day)
                     }

  # get all practices for this week, grouped by day, and sum the minutes for each day
  scope :this_week_grouped, lambda {
                              this_week.select("to_char(DATE(practice_date), 'Day')").group("to_char(DATE(practice_date), 'Day')").sum(:minutes)
                            }
  # get total sum of minutes for this week
  scope :this_week_total, -> { this_week.sum(:minutes) }

  # get all practicds grouped by practice date without time, and sum the minutes for each day
  scope :grouped_by_day, -> { select('DATE(practice_date)').group('DATE(practice_date)').sum(:minutes) }

  # get earliest practice_date
  scope :first_practice_date, -> { order(:practice_date).first.practice_date }

  scope :in_week, lambda { |date|
                    where(practice_date: date.beginning_of_week.beginning_of_day..(date + 1.week).beginning_of_day)
                  }

  scope :on_date, ->(date) { where(practice_date: date.beginning_of_day..date.end_of_day) }

  def practice_day(focus_user)
    practice_date.in_time_zone(focus_user).strftime('%a, %d %b %Y')
  end

  def self.a_dull_month(date)
    # create a hash for each day of the date's month
    # add each day as the key
    # add 0 as the value
    month_end = date.month == Time.zone.now.month ? Time.zone.now : date.end_of_month
    (date.beginning_of_month..month_end).each_with_object({}) do |day, hash|
      hash[day.strftime('%a, %d %b %Y')] = 0
    end
  end

  def self.month_of_practices(date, focus_user)
    practice_days = focus_user.practices.this_month(date).group_by do |practice|
                      practice.practice_day(focus_user.time_zone)
                    end.collect { |p, ps| [p, ps.sum(&:minutes)] }
    a_dull_month(date).merge!(practice_days.to_h)
  end

  def show_timer?
    new_record?
  end

  def streak_length
    return 0 unless streak_began

    streak_start_date = streak_began.practice_date.to_date

    return 0 if practice_date < 1.day.ago.to_date

    potential_streak = (practice_date.to_date - streak_start_date).to_i + 1

    return 0 if potential_streak < 3

    potential_streak
  end

  def first_practice_yesterday
    yesterday = practice_date.yesterday
    user.practices.where(practice_date: yesterday.beginning_of_day..yesterday.end_of_day).order(:practice_date).first
  end

  def set_streak_beginning!
    streak_began_id = if first_practice_yesterday.present? && first_practice_yesterday.streak_began_id.present?
      first_practice_yesterday.streak_began_id
    else
      self.id
    end
    binding.pry unless streak_began_id.present?
    self.update!(streak_began_id: streak_began_id)
  end

end
