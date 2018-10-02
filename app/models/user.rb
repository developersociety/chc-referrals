class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :reviews

  validates :first_name, :last_name, presence: true
end
