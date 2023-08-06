class AddUserToPractice < ActiveRecord::Migration[7.0]
  def change
    add_reference :practices, :user, null: false, foreign_key: true
  end
end
