
class GameMatch < ApplicationRecord
  # Define as associações entre GameMatch, Kill e Player
  has_many :kills
  has_many :players, through: :kills, source: :killer

  # Método para analisar o arquivo de log
  def self.parse_log(log_file_path)
    current_match = nil

    # Itera pelas linhas do arquivo de log
    File.open(log_file_path, 'r').each_line do |line|
      if line.include?('InitGame:')
        # Inicia uma nova partida quando encontra 'InitGame:'
        current_match = GameMatch.create
      elsif line.include?('Kill:')
        # Analisa a linha de morte quando encontra 'Kill:'
        parse_kill_line(line, current_match) if current_match
        current_match.save if current_match
      end
    end
  end

  # Método para analisar uma linha de morte
  def self.parse_kill_line(line, current_match)
    parts = line.split
    killer_id = parts[2].to_i  # Converte para inteiro
    victim_id = parts[3].chomp(':').to_i  # Converte para inteiro
    cause_of_death = parts[4..-1].join(' ')

    # Encontra ou cria os jogadores envolvidos na morte
    killer = Player.find_or_create_by(id: killer_id)  # Usa ID para busca ou criação
    victim = Player.find_or_create_by(id: victim_id)  # Usa ID para busca ou criação

    # Cria uma nova instância de Kill associada à partida atual
    current_kill = current_match.kills.create!(
      killer: killer,
      victim: victim,
      cause_of_death: cause_of_death
    )
  end
end
