class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.text :full_url, null: false
      t.integer :views_count, null: false, default: 0

      t.timestamps
    end
  end
end
