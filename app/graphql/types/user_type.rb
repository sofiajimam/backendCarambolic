# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :username, String, null: true

    field :bookmarks, [Types::BookmarkType], null: true
  end
end
