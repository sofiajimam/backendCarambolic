# frozen_string_literal: true

module Mutations
  class StoryCreate < BaseMutation
    description "Create a story"

    argument :story_input, Types::StoryInputType, required: true

    field :story, Types::StoryType, null: true

    def resolve(story_input:)
      story = ::Story.new(
        is_public: story_input.is_public,
        bookmark_id: story_input.bookmark_id,
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
