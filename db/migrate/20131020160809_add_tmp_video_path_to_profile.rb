class AddTmpVideoPathToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :tmp_video_path, :string
  end
end
