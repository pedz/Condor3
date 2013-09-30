class AddAbstractToDefect < ActiveRecord::Migration
  def self.up
    add_column :defects, :abstract, :string
  end

  def self.down
    remove_column :defects, :abstract
  end
end
