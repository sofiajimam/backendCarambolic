class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :stories, through: :bookmarks

  validates :name, presence: true

  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
