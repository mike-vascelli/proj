class CreateMicroPosts < ActiveRecord::Migration
  def change
    create_table :micro_posts do |t|
      t.integer :user_id
      t.text :text

      t.timestamps null: false
    end
  end
end
