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
    assert game.apply_scores, [Score.find_by_game_id_and_user_id_and_points(game.id, player1.user_id, 10),
                               Score.find_by_game_id_and_user_id_and_points(game.id, player2.user_id, 0)]
  end
end
