# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :user_delete, mutation: Mutations::UserDelete
    field :story_delete, mutation: Mutations::StoryDelete
    field :story_create, mutation: Mutations::StoryCreate
    field :act_delete, mutation: Mutations::ActDelete
    field :act_create, mutation: Mutations::ActCreate
    field :bookmark_delete, mutation: Mutations::BookmarkDelete
    field :bookmark_create, mutation: Mutations::BookmarkCreate
    field :user_create, mutation: Mutations::UserCreate
  end
end
