class Category < ActiveRecord::Base
  belongs_to :quiz

  # Define a named scope for each state in STATUS
  STATUS = ['active', 'inactive']
  validates_inclusion_of :status, :in => STATUS
  STATUS.each { |s| named_scope s, :conditions => { :status => s } }
end
