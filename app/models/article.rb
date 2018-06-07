class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  # lists in descending order
  default_scope { order(created_at: :desc)}

  belongs_to :user
  # destroys comments if article is destroyed
  has_many :comments, dependent: :destroy

end
