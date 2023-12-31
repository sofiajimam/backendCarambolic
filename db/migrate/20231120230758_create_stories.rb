class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.string :thumbnail
      t.boolean :is_public

      t.timestamps
    end
  end
end
