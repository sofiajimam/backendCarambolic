# frozen_string_literal: true

module Mutations
  class UserDelete < BaseMutation
    description "Delete a user"

    argument :user_id, ID, required: true

    field :user, Types::UserType, null: true

    def resolve(user_id:)
      user = ::User.find_by(id: user_id)
      raise GraphQL::ExecutionError, "User not found" if user.nil?

      if user.destroy
        {
          user: user,
        }
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end
