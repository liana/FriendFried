require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  def test_vote
    assert Answer.new(:game_id => 1).vote(1), Vote.find_by_game_id_and_answer_id_and_friend_id(1,1,1)
  end
end
