class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :votes

#  validates_presence_of :content

  # Scopes
  named_scope :by_user, lambda {|user| {:conditions => (user || User.current).answers.to_sql} }

  def vote(friend_id)
    Vote.find_or_create_by_game_id_and_answer_id(self.game_id, self.id, :friend_id => friend_id)
  end
end
