require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_game_totals
    user = User.new
    game1 = Game.new(:name => '1')
    game2 = Game.new(:name => '2')
    Score.create(:game_id => game1.id, :points => 10, :user_id => user.id)
    Score.create(:game_id => game1.id, :points => 20, :user_id => user.id)
    Score.create(:game_id => game2.id, :points => 30, :user_id => user.id)
    Score.create(:game_id => game2.id, :points => 30, :user_id => 9999)
    assert user.game_totals, [{:name => '1', :game_id => user.id, :points => 30},{:name => '2', :game_id => user.id, :points => 30}]
  end

  def test_total_score
    user = User.new
    Score.create(:game_id => 1, :points => 10, :user_id => user.id)
    Score.create(:game_id => 1, :points => 20, :user_id => user.id)
    Score.create(:game_id => 2, :points => 30, :user_id => user.id)
    Score.create(:game_id => 3, :points => 30, :user_id => 9999)
    assert user.total_score, 50
  end
end
