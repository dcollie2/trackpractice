# frozen_string_literal: true

class CreateFoci < ActiveRecord::Migration[7.0]
  def change
    create_table :foci do |t|
      t.string :short_description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
