class CreatePosts < ActiveRecord::Migration[7.0]
  def up
    create_table :posts do |t|
      t.string "title"
      t.string "image"
      t.integer  "total_likes"
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end

  def down
  end

end


