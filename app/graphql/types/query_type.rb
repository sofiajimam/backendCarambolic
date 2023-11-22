# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :me, Types::UserType, null: true do
      description "Find the current user"
    end

    def me
      unauthorized_field unless context[:current_user]
      context[:current_user]
    end

    field :user, Types::UserType, null: false do
      description "Find a user by ID"
      argument :id, ID, required: true
    end

    def user(id:)
      ::User.find_by(id: id)
    end

    field :users, [Types::UserType], null: false do
      description "Find all users"
    end

    def users
      ::User.all
    end

    field :bookmark, Types::BookmarkType, null: false do
      description "Find a bookmark by ID"
      argument :id, ID, required: true
    end

    def bookmark(id:)
      ::Bookmark.find_by(id: id)
    end

    field :bookmarks, [Types::BookmarkType], null: false do
      description "Find all bookmarks"
    end

    def bookmarks
      ::Bookmark.all
    end

    field :story, Types::StoryType, null: false do
      description "Find a story by ID"
      argument :id, ID, required: true
    end

    def story(id:)
      ::Story.find_by(id: id)
    end

    field :stories, [Types::StoryType], null: false do
      description "Find all stories"
    end

    def stories
      ::Story.all
    end

    field :act, Types::ActType, null: false do
      description "Find an act by ID"
      argument :id, ID, required: true
    end

    def act(id:)
      ::Act.find_by(id: id)
    end

    field :acts, [Types::ActType], null: false do
      description "Find all acts"
    end

    def acts
      ::Act.all
    end
  end
end
