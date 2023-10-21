# frozen_string_literal: true

class ChangePracticeMinutesDefaultTo0 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :practices, :minutes, 0
  end
end
