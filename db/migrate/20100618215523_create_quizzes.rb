class CreateQuizzes < ActiveRecord::Migration
  def self.up
    create_table :quizzes do |t|
      t.string :name
      t.text :comment
      t.integer :category_id
      t.integer :master_id
      t.string :status, :default => 'active'

      t.timestamps
    end
  end

  def self.down
    drop_table :quizzes
  end
end
