class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :trackable, :confirmable, :lockable

  has_many :practices
  has_many :foci, -> { order(short_description: :asc) }
  has_many :songs, -> { order(title: :asc) }

  # add a public scope
  scope :with_public_practices, -> { where(make_practices_public: true) }

  def streak
    # return the count of days practiced without a break
    streak = 0
    # get all practices for this user, in descending order by practice_date, grouped by distinct practice_date.to_date
    # then loop through each practice_date.to_date
    # for each practice_date.to_date, if the next practice_date.to_date is the day after, increment the streak
    # if the next practice_date.to_date is not the day after, break the loop
    # return the streak
    today = DateTime.current.in_time_zone(time_zone).to_date

    practices.order(practice_date: :desc).group_by(&:practice_date).each_with_index do |(date, practices), index|
      practice_date = date.in_time_zone(time_zone).to_date

      if index <= 1 && practice_date == today
        streak += 1
      elsif index > 1 && practice_date == today - index.days
        streak += 1
      else
        break
      end
    end
    streak
  end
end
