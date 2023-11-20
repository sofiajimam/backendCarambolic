# frozen_string_literal: true

module Types
  class ActInputType < Types::BaseInputObject
    argument :title, String, required: true
    argument :body, String, required: true
    argument :image, String, required: true

    argument :story_id, ID, required: true
  end
end
