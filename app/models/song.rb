class Song < ApplicationRecord
  belongs_to :user
  has_many :practices

  # total practice time for this song
  def total_practice_time
    practices.present? ? practices.sum(:minutes) : 0
  end
end