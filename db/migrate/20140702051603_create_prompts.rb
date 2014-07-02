class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.integer :difficulty
      t.string :question

      t.timestamps
    end
  end
end
