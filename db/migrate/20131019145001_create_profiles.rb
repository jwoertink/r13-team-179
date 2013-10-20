class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :ip_address
      t.string :email
      t.string :video
      t.string :url_key

      t.timestamps
    end
  end
end
