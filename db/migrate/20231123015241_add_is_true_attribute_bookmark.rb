class AddIsTrueAttributeBookmark < ActiveRecord::Migration[7.0]
  def change
    change_table :bookmarks, bulk: true do |t|
      t.boolean :is_true, default: nil
    end
  end
end
