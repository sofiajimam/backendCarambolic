# frozen_string_literal: true

module Types
  class BookmarkType < Types::BaseObject
    field :id, ID, null: false
    field :url, String, null: true
    field :title, String, null: true
    field :thumbnail, String, null: true
    field :summary, String, null: true

    field :user, Types::UserType, null: true
    field :stories, [Types::StoryType], null: true
    field :is_true, Boolean, null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
