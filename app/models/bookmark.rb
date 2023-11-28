class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :stories, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true, uniqueness: { scope: :user_id }
  validates :thumbnail, presence: true
  validates :summary, presence: false
end
