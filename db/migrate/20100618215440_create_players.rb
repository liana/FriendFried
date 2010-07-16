class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :status, :default => 'active'

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
