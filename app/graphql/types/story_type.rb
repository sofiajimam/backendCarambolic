# frozen_string_literal: true

module Types
  class StoryType < Types::BaseObject
    field :id, ID, null: false
    field :is_public, Boolean, null: true
    field :bookmark, Types::BookmarkType, null: true
    field :acts, [Types::ActType], null: true

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
