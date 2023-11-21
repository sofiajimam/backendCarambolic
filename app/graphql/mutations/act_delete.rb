# frozen_string_literal: true

module Mutations
  class ActDelete < BaseMutation
    description "Delete an act"

    argument :act_id, ID, required: true

    field :act, Types::ActType, null: true

    def resolve(act_id:)
      act = ::Act.find(act_id)

      if act.destroy
        {
          act: act,
        }
      else
        raise GraphQL::ExecutionError, act.errors.full_messages.join(", ")
      end
    end
  end
end
