class AddScoreToGameMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :game_matches, :score, :integer
  end
end

