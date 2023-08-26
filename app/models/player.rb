class Player < ApplicationRecord
  has_many :kills_as_killer, class_name: 'Kill', foreign_key: :killer_id
  has_many :kills_as_victim, class_name: 'Kill', foreign_key: :victim_id
end
