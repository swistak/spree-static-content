class Page < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :slug
  validates_presence_of :body

  named_scope :visible, :conditions => {:visible => true}
  default_scope :order => "position ASC"

  def initialize(*args)
    super(*args)
    self.position = Page.last.position + 1
  end

  def before_save
    unless new_record?
      return unless prev_position = Page.find(self.id).position
      if prev_position > self.position
        Page.update_all("position = position + 1", ["? <= position AND position < ?", self.position, prev_position])
      elsif prev_position < self.position
        Page.update_all("position = position - 1", ["? < position AND position <= ?", prev_position,  self.position])
      end
    end
  end
end
