# frozen_string_literal: true

class Song < ApplicationRecord
  belongs_to :user
  has_many :practices

  has_rich_text :lyrics
  has_rich_text :chords

  validates :title, presence: true

  # total practice time for this song
  def total_practice_time
    practices.present? ? practices.sum(:minutes) : 0
  end
end
