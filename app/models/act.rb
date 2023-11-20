class Act < ApplicationRecord
  belongs_to :story

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
end
