class StreakData < ActiveRecord::Migration[7.1]
  def up
    User.all.each do |user|
      user.practices.order(:practice_date).each do |practice|
        practice.set_streak_beginning!
      end
    end
  end
end
