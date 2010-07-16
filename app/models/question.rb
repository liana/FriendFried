class Question < ActiveRecord::Base
 has_many :answers, :dependent => :destroy

# validates_presence_of :content

 default_scope :order => 'display_order ASC'

 accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:label].blank? }, :allow_destroy => true

 def answered_by
   answers.each{|a| a.user}
 end
end
