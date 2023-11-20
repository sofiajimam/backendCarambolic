# frozen_string_literal: true

module Types
  class BookmarkInputType < Types::BaseInputObject
    argument :title, String, required: true
    argument :url, String, required: true
    argument :thumbnail, String, required: true
    argument :summary, String, required: true

    argument :user_id, ID, required: true
  end
end
