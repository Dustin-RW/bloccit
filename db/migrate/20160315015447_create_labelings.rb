class CreateLabelings < ActiveRecord::Migration
  def change
    create_table :labelings do |t|
      t.references :label, index: true
      #creates a column which will have the name labelable_id and polymorphic: true which adds
      #a type column called labelable_type
      t.references :labelable, polymorphic: true, index: true

      t.timestamps null: false
    end
    add_foreign_key :labelings, :labels
  end
end
