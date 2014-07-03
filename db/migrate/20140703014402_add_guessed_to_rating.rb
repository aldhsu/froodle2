class AddGuessedToRating < ActiveRecord::Migration
  def up
    add_column :ratings, :guessed, :integer, default: 0
  end
end
