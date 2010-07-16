require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def test_apply_scores
    game = Game.create(:status => 'active')
    player1 = Player.create(:game_id => game.id, :status => 'active', :user_id => 5)
    player2 = Player.create(:game_id => game.id, :status => 'active', :user_id => 6)
    player3 = Player.create(:game_id => game.id, :status => 'active', :user_id => 7)

    answer = Answer.create(:game_id => game.id, :player_id => player3.id)
    votes = [Vote.create(:player_id => player1.id, :answer_id => answer.id, :game_id => game.id, :friend_id => player3.id),
             Vote.create(:player_id => player2.id, :answer_id =>  answer.id, :game_id => game.id, :friend_id => player1.id)]
    assert_equal [10, 0, 0], game.apply_scores.sort_by(&:user_id).collect{|s| s.points}
  end

  def test_user_score
    user = User.new
    game = Game.new
    Score.create(:game_id => game.id, :points => 10, :user_id => user.id)
    Score.create(:game_id => game.id, :points => 20, :user_id => user.id)
    Score.create(:game_id => Game.new, :points => 30, :user_id => user.id)
    Score.create(:game_id => Game.new, :points => 30, :user_id => 9999)
    assert_equal 30, game.user_score(user)
  end

  def test_top_score
    game = Game.create
    score1 = Score.create(:game_id => game.id, :points => 10, :user_id => 1)
    score2 = Score.create(:game_id => game.id, :points => 50, :user_id => 2)
    score3 = Score.create(:game_id => game.id, :points => 20, :user_id => 3)
    assert_equal score2, game.top_score
  end
end
