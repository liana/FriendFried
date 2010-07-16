class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :quiz_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :friend_id

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
