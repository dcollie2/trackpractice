# frozen_string_literal: true

class StreakData < ActiveRecord::Migration[7.1]
  def up
    User.all.find_each do |user|
      user.practices.order(:practice_date).each do |practice|
        practice.update!(minutes: 5) if practice.minutes.blank? || practice.minutes < 1
        practice.set_streak_beginning!
      end
    end
  end
end
