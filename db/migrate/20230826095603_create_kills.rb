class CreateKills < ActiveRecord::Migration[7.0]
  def change
    create_table :kills do |t|
      t.belongs_to :killer, foreign_key: { to_table: :players }
      t.belongs_to :victim, foreign_key: { to_table: :players }
      t.string :cause_of_death
      t.timestamps
    end
  end
end
