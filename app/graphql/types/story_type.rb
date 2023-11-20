# frozen_string_literal: true

module Types
  class StoryType < Types::BaseObject
    field :id, ID, null: false
    field :is_public, Boolean, null: true
    field :bookmark, Types::BookmarkType, null: true
    field :acts, [Types::ActType], null: true

    def bookmark
      Loaders::RecordLoader.for(Bookmark).load(object.bookmark_id)
    end
  end
end
