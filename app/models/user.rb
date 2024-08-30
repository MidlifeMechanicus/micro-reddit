class User < ApplicationRecord
  validates :username,
    presence: true,
    uniqueness: true,
    length: { in: 4..16 }
  validates :email,
    presence: true, uniqueness: { case_insensitive: true },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password,
    presence: true,
    length: { in: 4..16 }
  has_many :posts
  has_many :comments
end
