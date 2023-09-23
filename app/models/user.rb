class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :trackable, :confirmable, :lockable

  has_many :practices, dependent: :destroy
  has_many :foci, -> { order(short_description: :asc) }, dependent: :destroy
  has_many :songs, -> { order(title: :asc) }, dependent: :destroy

  validates :time_zone, presence: true

  # add a public scope
  scope :with_public_practices, -> { where(make_practices_public: true) }

  def streak
    # return the count of days practiced without a break
    streak = 0

    # get user's practies in descending order by practice_date
    user_practices = practices.order(practice_date: :desc)

    # we're starting either today or yesterday
    today = Time.now.in_time_zone(time_zone).to_date
    starting_date = user_practices.first.practice_date.in_time_zone(time_zone).to_date
    logger.debug "today: #{today} - starting_date: #{starting_date}"

    # if practice is older than yesterday, return 0
    return 0 if starting_date < today - 1.day

    # get all practices for this user, in descending order by practice_date, grouped by distinct practice_date.to_date
    # then loop through each practice_date.to_date
    # for each practice_date.to_date, if the next practice_date.to_date is the day after, increment the streak
    # if the next practice_date.to_date is not the day after, break the loop
    # return the streak
    user_practices.group_by { |p| p.practice_day(time_zone) }.each_with_index do |(date, practices), index|
      practice_date = date.in_time_zone(time_zone).to_date
      Rails.logger.debug "practice_date: #{starting_date} - today: #{today} - index: #{index}"

      if index == 0 && starting_date >= today - 1.day
        # practiced on starting date
        streak += 1
        Rails.logger.debug "streak: #{streak} - Today CONDITION"
      elsif index == 0 && practice_date == starting_date - 1.day
        # didn't practice on starting date but did day before
        streak += 1
        Rails.logger.debug "streak: #{streak} - Yesterday CONDITION"
      elsif index > 0 && practice_date == starting_date - index.days
        # another consecuetive day
        streak += 1
        Rails.logger.debug "streak: #{streak} - Continuing CONDITION"
      else
        # broke the stres
        Rails.logger.debug "streak: #{streak} - BREAKING - #{starting_date} != #{starting_date - index.days}"
        break
      end
    end
    streak
  end
end
