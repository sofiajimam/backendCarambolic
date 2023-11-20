class CreateActs < ActiveRecord::Migration[7.0]
  def change
    create_table :acts do |t|
      t.string :title
      t.string :body
      t.string :image

      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
