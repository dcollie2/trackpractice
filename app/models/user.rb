class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :trackable, :confirmable, :lockable

  has_many :practices
  has_many :foci, -> { order(short_description: :asc) }
  has_many :songs, -> { order(title: :asc) }

  # add a public scope
  scope :with_public_practices, -> { where(make_practices_public: true) }
end
