class AddNameToGameMatches < ActiveRecord::Migration[7.0]
  def change
    add_column :game_matches, :name, :string
  end
end
