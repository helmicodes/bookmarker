class User < ApplicationRecord
  has_secure_password

  has_many :links

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
