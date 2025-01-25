# frozen_string_literal: true

class AddStreakBeganId < ActiveRecord::Migration[7.1]
  def change
    add_column :practices, :streak_began_id, :integer
  end
end
