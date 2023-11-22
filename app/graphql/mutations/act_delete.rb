# frozen_string_literal: true

module Mutations
  class ActDelete < BaseMutation
    description "Delete an act"

    argument :act_id, ID, required: true

    field :act, Types::ActType, null: true

    def resolve(act_id:)
      act = ::Act.find_by(id: act_id)
      raise GraphQL::ExecutionError, "Act not found" if act.nil?

      if act.destroy
        {
          # return success message
          message: "Act deleted successfully",
        }
      else
        raise GraphQL::ExecutionError, act.errors.full_messages.join(", ")
      end
    end
  end
end
