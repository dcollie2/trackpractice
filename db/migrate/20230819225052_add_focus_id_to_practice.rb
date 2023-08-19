class AddFocusIdToPractice < ActiveRecord::Migration[7.0]
  def change
    add_column :practices, :focus_id, :integer, index: true
  end
end
