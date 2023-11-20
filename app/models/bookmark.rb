class Bookmark < ApplicationRecord
  belongs_to :user
  has_many :stories, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true
  validates :thumbnail, presence: true
  validates :summary, presence: true
end
