# frozen_string_literal: true

module Mutations
  class StoryCreate < BaseMutation
    description "Create a story"

    argument :story_input, Types::StoryInputType, required: true

    field :story, Types::StoryType, null: true

    def resolve(story_input:)
      bookmark = ::Bookmark.find_by(id: story_input.bookmark_id)
      raise GraphQL::ExecutionError, "Bookmark not found" if bookmark.nil?

      story = ::Story.new(
        is_public: story_input.is_public,
        bookmark_id: story_input.bookmark_id,
        title: bookmark.title,
        url: bookmark.url,
        thumbnail: bookmark.thumbnail,
      )

      if story.save
        {
          story: story,
        }
      else
        raise GraphQL::ExecutionError, story.errors.full_messages.join(", ")
      end
    end
  end
end
