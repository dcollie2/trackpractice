# frozen_string_literal: true

class ChangePracticeMinutesDefaultTo0 < ActiveRecord::Migration[7.0]
  def up
    change_column_default :practices, :minutes, 0
  end

  def down
    change_column_default :practices, :minutes, nil
  end
end
