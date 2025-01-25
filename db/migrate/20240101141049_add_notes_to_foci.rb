# frozen_string_literal: true

class AddNotesToFoci < ActiveRecord::Migration[7.1]
  def change
    add_column :foci, :notes, :text
  end
end
