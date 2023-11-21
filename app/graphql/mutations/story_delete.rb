# frozen_string_literal: true

module Mutations
  class StoryDelete < BaseMutation
    description "Delete a story"

    argument :story_id, ID, required: true

    field :story, Types::StoryType, null: true

    def resolve(story_id:)
      story = ::Story.find(story_id)
      raise GraphQL::ExecutionError, "Story not found" if story.nil?

      if story.destroy
        {
          story: story,
        }
      else
        raise GraphQL::ExecutionError, story.errors.full_messages.join(", ")
      end
    end
  end
end
