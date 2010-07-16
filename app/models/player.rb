class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  belongs_to :game
  has_many :votes

 # Define a named scope for each state in STATUS
 STATUS = ['active', 'inactive']
 validates_inclusion_of :status, :in => STATUS
 STATUS.each { |s| named_scope s, :conditions => { :status => s } }

  after_create :send_ff_notification

  def send_ff_notification
#    send_as :notification
#    recipients  self.quiz.players
#    from self.quiz.owner.facebook_session.user
#    fbml  <<-MESSAGE
#  	  <fb:fbml>
#  	  #You've been FriendFried!
#  	  #{name} just completed the #{self.quiz.name} quiz.
#  	  #{link_to "Fry your friends", new_player_url}
#  	  </fb:fbml>
#  	MESSAGE
#  rescue Facebooker::Session::SessionExpired
#    # We can't recover from this error, but
#    # we don't want to show an error to our user
  end

end
