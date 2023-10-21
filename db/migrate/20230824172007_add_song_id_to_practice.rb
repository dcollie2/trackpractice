# frozen_string_literal: true

class AddSongIdToPractice < ActiveRecord::Migration[7.0]
  def change
    add_column :practices, :song_id, :integer
  end
end
