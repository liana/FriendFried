class User < ActiveRecord::Base
  has_many :scores
  has_many :games, :foreign_key => 'owner_id'
  
  acts_as_authentic do |c|
        #c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
      end # block optional
      
  def self.for(facebook_id,facebook_session=nil)
    returning find_or_create_by_facebook_id(facebook_id) do |user|
      unless facebook_session.nil?
        user.store_session(facebook_session.session_key)
      end
    end
  end


  def store_session(session_key)
    if self.session_key != session_key
      update_attribute(:session_key,session_key)
    end
  end

  def facebook_session
    @facebook_session ||=
      returning Facebooker::Session.create do |session|
        session.secure_with!(session_key,facebook_id,1.day.from_now)
    end
  end

  def game_totals
    Score.find(:all, 
               :select => 'name, game_id, SUM(points) as points',
               :joins=>[:game],
               :group => 'game_id, name',
               :conditions => {:user_id => self.id},
               :order => :game_id).collect { |s| {:name =>s.name, :game_id => s.game_id, :points => s.points}  }
  end

  def total_score
    Score.find(:first, :select => 'SUM(points) as points', :conditions => {:user_id => self.id}).points
  end
end
