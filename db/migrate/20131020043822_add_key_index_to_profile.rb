class AddKeyIndexToProfile < ActiveRecord::Migration
  def change
    add_index :profiles, :url_key
  end
end
