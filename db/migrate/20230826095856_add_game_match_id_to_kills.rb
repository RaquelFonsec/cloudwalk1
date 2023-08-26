class AddGameMatchIdToKills < ActiveRecord::Migration[7.0]
  def change
    add_reference :kills, :game_match, null: false, foreign_key: true
  end
end
