# frozen_string_literal: true

module Types
  class StoryInputType < Types::BaseInputObject
    argument :is_public, Boolean, required: true
    argument :bookmark_id, ID, required: true
  end
end
