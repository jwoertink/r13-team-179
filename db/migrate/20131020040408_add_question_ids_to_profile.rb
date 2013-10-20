class AddQuestionIdsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :question_ids, :integer, array: true, default: []
    
    add_index :questions, :category
  end
end
