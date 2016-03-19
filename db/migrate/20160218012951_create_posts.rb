class CreatePosts < ActiveRecord::Migration
  def change
    # create_table takes a block that specifies the attributes
    # we want our table to possess.
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
