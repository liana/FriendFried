class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def self.game_totals(user)
    Score.find(:all, :select => 'name, game_id, SUM(points) as points', :joins=>[:game], :group => 'game_id, name', :conditions => {:user_id => user.id})
  end

  def self.total_score(user)
    Score.find(:all, :select => 'SUM(points) as points', :conditions => {:user_id => user.id})
  end
end
