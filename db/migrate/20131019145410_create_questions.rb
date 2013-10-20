class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :category
      t.string :video

      t.timestamps
    end
  end
end
