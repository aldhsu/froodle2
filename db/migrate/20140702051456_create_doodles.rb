class CreateDoodles < ActiveRecord::Migration
  def change
    create_table :doodles do |t|
      t.integer :prompt_id
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
