# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: true
    field :name, String, null: true

    field :bookmarks, [Types::BookmarkType], null: false

    field :bookmark, Types::BookmarkType, null: false do
      description "Find a bookmark by ID"
      argument :id, ID, required: true
    end

    def bookmark(id:)
      object.bookmarks.find_by(id: id)
    end

    field :stories, [Types::StoryType], null: false

    field :story, Types::StoryType, null: false do
      description "Find a story by ID"
      argument :id, ID, required: true
    end

    def story(id:)
      story = object.stories.find_by(id: id)
      raise GraphQL::ExecutionError, "Story not found" unless story
      story
    end

    # query stories
    field :stories_by_query, [Types::StoryType], null: false do
      description "Find stories with text contained in the title or body"
      argument :text, String, required: true
    end

    def stories_by_query(text:)
      object.stories.where("stories.title LIKE ?", "%#{text}%")
    end

    # query bookmarks
    field :bookmarks_by_query, [Types::BookmarkType], null: false do
      description "Find bookmarks with text contained in the title or body"
      argument :text, String, required: true
    end

    def bookmarks_by_query(text:)
      object.bookmarks.where("bookmarks.title LIKE ?", "%#{text}%")
    end

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
