class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.text :comment
      t.integer :game_id
      t.string :status, :default => 'active'

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
