# frozen_string_literal: true

module Mutations
  class BookmarkCreate < BaseMutation
    description "Create a new bookmark"

    argument :bookmark_input, Types::BookmarkInputType, required: true

    field :bookmark, Types::BookmarkType, null: true

    def resolve(bookmark_input:)
      current_user = context[:current_user]

      bookmark = ::Bookmark.new(
        title: bookmark_input.title,
        url: bookmark_input.url,
        thumbnail: bookmark_input.thumbnail,
        summary: bookmark_input.summary,
        user_id: current_user.id,
      )

      if bookmark.save
        {
          bookmark: bookmark,
        }
      else
        raise GraphQL::ExecutionError, bookmark.errors.full_messages.join(", ")
      end
    end
  end
end
