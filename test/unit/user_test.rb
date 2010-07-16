require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_game_totals
    user = User.create
    game1 = Game.create(:name => '1')
    game2 = Game.create(:name => '2')
    Score.create(:game_id => game1.id, :points => 10, :user_id => user.id)
    Score.create(:game_id => game1.id, :points => 20, :user_id => user.id)
    Score.create(:game_id => game2.id, :points => 30, :user_id => user.id)
    Score.create(:game_id => game2.id, :points => 50, :user_id => 9999)
    assert_equal [{:name => '1', :game_id => game1.id, :points => 30},{:name => '2', :game_id => game2.id, :points => 30}], user.game_totals
  end

  def test_total_score
    user = User.new
    Score.create(:game_id => 1, :points => 10, :user_id => user.id)
    Score.create(:game_id => 1, :points => 20, :user_id => user.id)
    Score.create(:game_id => 2, :points => 30, :user_id => user.id)
    Score.create(:game_id => 3, :points => 30, :user_id => 9999)
    assert_equal 60, user.total_score
  end
end
