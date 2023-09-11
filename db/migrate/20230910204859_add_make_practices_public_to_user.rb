class AddMakePracticesPublicToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :make_practices_public, :boolean
  end
end
