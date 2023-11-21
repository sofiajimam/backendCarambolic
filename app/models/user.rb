class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true

  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
