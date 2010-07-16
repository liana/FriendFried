class Vote < ActiveRecord::Base
  belongs_to :answer
  belongs_to :player  
  named_scope :by_game, lambda { |game| { :conditions => { :game_id => game } } }
  named_scope :by_user, lambda { |user| { :conditions => { :user_id => user } } }
end
