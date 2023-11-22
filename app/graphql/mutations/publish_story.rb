# frozen_string_literal: true

module Mutations
  class PublishStory < BaseMutation
    description "Publish a story"

    argument :story_id, ID, required: true

    field :story, Types::StoryType, null: true

    def resolve(story_id:)
      story = ::Story.find_by(id: story_id)
      raise GraphQL::ExecutionError, "Story not found" if story.nil?

      if story.update(is_public: true)
        {
          story: story,
        }
      else
        raise GraphQL::ExecutionError, story.errors.full_messages.join(", ")
      end
    end
  end
end
