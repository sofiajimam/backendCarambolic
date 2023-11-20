# frozen_string_literal: true

module Types
  class ActType < Types::BaseObject
    field :id, ID, null: false
    field :story, Types::StoryType, null: true
    field :title, String, null: true
    field :body, String, null: true
    field :image, String, null: true
  end
end
