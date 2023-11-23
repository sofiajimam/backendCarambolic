# frozen_string_literal: true

module Mutations
  class BookmarkUpdate < BaseMutation
    description "Update a bookmark"

    argument :bookmark_id, ID, required: true

    argument :bookmark_input, Types::BookmarkInputType, required: true

    field :bookmark, Types::BookmarkType, null: true

    def resolve(bookmark_id:, bookmark_input:)
      bookmark = ::Bookmark.find_by(id: bookmark_id)
      raise GraphQL::ExecutionError, "Bookmark not found" if bookmark.nil?

      if bookmark.update(
        summary: bookmark_input.thumbnail,
      )
        {
          bookmark: bookmark,
        }
      else
        raise GraphQL::ExecutionError, bookmark.errors.full_messages.join(", ")
      end
    end
  end
end
