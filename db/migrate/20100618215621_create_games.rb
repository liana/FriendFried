class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :quiz_id
      t.integer :owner_id
      t.string  :name, :default => Date.today.to_s
      t.string  :status, :default => 'active'
      t.integer :players_count, :integer, :default => 0
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
