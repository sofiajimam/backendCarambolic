# frozen_string_literal: true

module Mutations
  class BookmarkDelete < BaseMutation
    description "Delete a bookmark"

    argument :bookmark_id, ID, required: true

    field :bookmark, Types::BookmarkType, null: true

    def resolve(bookmark_id:)
      bookmark = ::Bookmark.find(bookmark_id)

      if bookmark.destroy
        {
          bookmark: bookmark,
        }
      else
        raise GraphQL::ExecutionError, bookmark.errors.full_messages.join(", ")
      end
    end
  end
end