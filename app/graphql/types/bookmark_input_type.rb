# frozen_string_literal: true

module Types
  class BookmarkInputType < Types::BaseInputObject
    argument :title, String, required: false # create
    argument :url, String, required: false # create
    argument :thumbnail, String, required: false # create
    argument :summary, String, required: false # update
    argument :html_content, String, required: false # update
  end
end
