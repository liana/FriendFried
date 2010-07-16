class AddGameId < ActiveRecord::Migration
  def self.up
    rename_column :players, :quiz_id, :game_id
    rename_column :rules, :quiz_id, :game_id
    add_column :scores, :game_id, :integer
  end

  def self.down
    rename_column :players, :game_id, :quiz_id
    rename_column :rules, :game_id, :quiz_id
    remove_column :scores, :game_id
  end
end
