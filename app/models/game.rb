class Game < ActiveRecord::Base
  has_many :players
  has_many :scores
  belongs_to :quiz
  belongs_to :user, :foreign_key => 'owner_id'

 # Define a named scope for each state in STATUS
 STATUS = ['active', 'inactive', 'ended', 'waiting']
 validates_inclusion_of :status, :in => STATUS
 STATUS.each { |s| named_scope s, :conditions => { :status => s } }

 POINTS = 10

  def apply_scores
    votes = Vote.by_game(self.id)
    game_scores = players.active.map(&:user_id).inject({}) {|h, v| h[v] = 0; h }
    votes.each { |v| game_scores[v.player.user_id] += POINTS if v.friend_id == v.answer.player_id }
    Score.delete_all(self.scores)
    game_scores.collect { |s| Score.create(:game_id => self.id, :user_id => s[0], :points => s[1])}
  end

  def user_score(user)
    Score.find(:first, :select => 'SUM(points) as points', :conditions => {:user_id => user.id, :game_id => self.id}).points
  end

  def top_score
    Score.find(:first, :order => 'points DESC', :conditions => {:game_id => self.id})
  end
end
