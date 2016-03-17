class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      #automatically creates commentable_id:integer and commentable_type:string
      t.belongs_to :commentable, polymorphic: true

      t.timestamps null: false
    end
    #associates both commetables to comments
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
