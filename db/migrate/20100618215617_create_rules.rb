class CreateRules < ActiveRecord::Migration
  def self.up
    create_table :rules do |t|
      t.string :name
      t.text :comment
      t.integer :points
      t.string :status, :default => 'active'
      t.integer :game_id
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rules
  end
end
