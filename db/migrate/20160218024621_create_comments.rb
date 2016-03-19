class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body

      # references line tells the database to index the post_id column to comments,
      # so it can be searched efficiently. This is always a good idea for
      # foreign keys, and is added automatically when you generate with the
      # references argument.
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
