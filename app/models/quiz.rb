class Quiz < ActiveRecord::Base
  has_many :users, :through => :players
  has_many :games
  has_many :categories
  has_many :questions, :dependent => :destroy, :order => "display_order ASC"
  belongs_to :master, :class_name => 'User', :foreign_key => 'master_id'

  validates_presence_of :name
  validates_uniqueness_of :name

 # Define a named scope for each state in STATUS
 STATUS = ['active', 'inactive']
 validates_inclusion_of :status, :in => STATUS
 STATUS.each { |s| named_scope s, :conditions => { :status => s } }

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a['content'].blank? }, :allow_destroy => true


  def active?
    (self.start_at.nil? or self.start_at < DateTime.now) and (self.end_at.nil? or self.end_at > DateTime.now)
  end

  def activate!
    self.start_at = DateTime.now
  end

  def deactivate!
    self.end_at = DateTime.now
  end

#  def name=(value)
#    # replace non-alphanumeric with "-". remove repeat "-"s. don't start or end with "-"
#    self.name = normalize_string(value)
#  end
#
#  # code stolen from one of the ruby MLs.
#  def normalize_string(foo)
#    foo.downcase.strip
#  end
end
