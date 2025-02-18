# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :trackable, :confirmable, :lockable

  has_many :practices, dependent: :destroy
  has_many :foci, -> { order(short_description: :asc) }, dependent: :destroy, inverse_of: :user
  has_many :songs, -> { order(title: :asc) }, dependent: :destroy, inverse_of: :user

  validates :email, presence: true
  validates :time_zone, presence: true

  after_create :create_default_foci

  # add a public scope
  scope :with_public_practices, -> { where(make_practices_public: true) }

  def create_default_foci
    Focus::STOCK_FOCI.each do |focus|
      foci.create(short_description: focus)
    end
  end

  def most_recent_practice
    return if practices.blank?

    practice = practices.order(practice_date: :desc).first
    practice_days_ago = (Time.zone.now.to_date - practice.practice_date.to_date).to_i
    practice_days_ago <= 2 ? practice : nil
  end

  def streak
    # return the count of days practiced without a break
    if most_recent_practice.nil?
      0
    elsif most_recent_practice.practice_date < 2.days.ago
      0
    else
      most_recent_practice.streak_length
    end
  end

  def streaks
    streaks = {}
    practices.order(:practice_date).includes(:streak_began).group_by(&:streak_began).each do |streak_began, practices|
      streaks[streak_began.practice_date.to_s] = practices.last.streak_length if practices.last.streak_length > 3
    end
    streaks
  end

  def longest_streak
    # return the longest streak of days practiced without a break
    if streaks.empty?
      0
    else
      streaks.values.max
    end
  end

  def approaching_streak?
    # return true if the user is within 5 days of their longest streak
    longest_streak - streak <= 5 && streak < longest_streak
  end
end
