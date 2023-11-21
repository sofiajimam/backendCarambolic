class AddReferenceBookMarkStories < ActiveRecord::Migration[7.0]
  def change
    add_reference :stories, :bookmark, foreign_key: true
  end
end
