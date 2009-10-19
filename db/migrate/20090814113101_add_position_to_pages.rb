class AddPositionToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :position, :integer, :default => 1
    Page.all(:order => "updated_at ASC").each_with_index{|page,x| page.update_attribute(:position, x+1)}
  end

  def self.down
    remove_column :pages, :visible
  end
end
