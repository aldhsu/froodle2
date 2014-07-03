class AddGuessedToRating < ActiveRecord::Migration
  def up
    add_column :rating, :guessed, :boolean, default: false
  end
end
