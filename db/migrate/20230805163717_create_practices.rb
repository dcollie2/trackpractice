# frozen_string_literal: true

class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.datetime :practice_date
      t.integer :minutes
      t.text :notes

      t.timestamps
    end
  end
end
