class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :quiz_id
      t.integer :parent_id
      t.string :content
      t.integer :display_order
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
