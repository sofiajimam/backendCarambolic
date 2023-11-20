class Story < ApplicationRecord
  belongs_to :bookmark
  has_many :acts, dependent: :destroy
  validates :title, presence: true
  validates :url, presence: true
  validates :thumbnail, presence: true

  validates :is_public, inclusion: { in: [true, false] }
end
