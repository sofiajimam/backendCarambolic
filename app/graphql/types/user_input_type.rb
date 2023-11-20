# frozen_string_literal: true

module Types
  class UserInputType < Types::BaseInputObject
    argument :email, String, required: true
    argument :name, String, required: true
  end
end
