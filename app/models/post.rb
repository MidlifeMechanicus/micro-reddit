class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 3 }
  validates :user_id, presence: true
  belongs_to :user
end
