class ChangeArrayToString < ActiveRecord::Migration
  def change
    change_column :profiles, :question_ids, :string
  end
end
