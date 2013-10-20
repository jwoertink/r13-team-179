class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :email
      t.string :gender
      t.integer :profile_id

      t.timestamps
    end
    add_index :interests, :profile_id
  end
end
