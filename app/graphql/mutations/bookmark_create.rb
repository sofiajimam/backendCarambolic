# frozen_string_literal: true

module Mutations
  class BookmarkCreate < BaseMutation
    description "Create a new bookmark"

    argument :bookmark_input, Types::BookmarkInputType, required: true

    field :bookmark, Types::BookmarkType, null: true

    def resolve(bookmark_input:)
      current_user = context[:current_user]

      bookmark = ::Bookmark.new(
        title: bookmark_input.title, # head title
        url: bookmark_input.url, # url de la pagina
        thumbnail: bookmark_input.thumbnail, # favicon
        user_id: current_user.id,
      )

      if bookmark.save
        OpenaiRequestJob.perform_later(bookmark.id, bookmark_input.html_content)
        {
          bookmark: bookmark,
        }
      else
        raise GraphQL::ExecutionError, bookmark.errors.full_messages.join(", ")
      end
    end

    private
  end
end
