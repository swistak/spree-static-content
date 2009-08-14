class Page < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :body
 
  named_scope :visible, :conditions => {:visible => true}
end
