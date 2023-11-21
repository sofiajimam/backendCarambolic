# frozen_string_literal: true

module Mutations
  class ActCreate < BaseMutation
    description "Create a new act"

    argument :act_input, Types::ActInputType, required: true

    field :act, Types::ActType, null: true

    def resolve(act_input:)
      act = ::Act.new(
        title: act_input.title,
        body: act_input.body,
        image: act_input.image,
        story_id: act_input.story_id,
      )

      if act.save
        {
          act: act,
        }
      else
        raise GraphQL::ExecutionError, act.errors.full_messages.join(", ")
      end
    end
  end
end
