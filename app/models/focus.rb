# frozen_string_literal: true

class Focus < ApplicationRecord
  STOCK_FOCI = ['Learning Song', 'CAGED', 'Major Scales', 'Minor Scales', 'Major Pentatonics', 'Minor Pentatonics',
                'Performance', 'Recording Song', 'Learning Song'].freeze

  belongs_to :user
  has_many :practices

  has_rich_text :notes

  validates :short_description, presence: true

  # total practice time for this focus
  def total_practice_time
    practices.present? ? practices.sum(:minutes) : 0
  end
end
