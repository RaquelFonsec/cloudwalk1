
class CreateGameMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :game_matches do |t|
      t.datetime :start_time
      t.datetime :end_time
      # outros campos que você desejar
      t.timestamps
    end
  end
end
