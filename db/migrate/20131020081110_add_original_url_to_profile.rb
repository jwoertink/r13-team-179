class AddOriginalUrlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :original_url, :string
  end
end
