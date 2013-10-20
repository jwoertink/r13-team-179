class AddStatusToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :completed, :boolean, default: false
    
    add_index :profiles, :completed
  end
end
