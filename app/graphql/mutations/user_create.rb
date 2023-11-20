# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description "Create a new user"

    argument :user_input, Types::UserInputType, required: true

    field :user, Types::UserType, null: true

    def resolve(user_input:)
      user = ::User.new(
        name: user_input.name,
        email: user_input.email,
      )

      if user.save
        {
          user: user,
        }
      else
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end
