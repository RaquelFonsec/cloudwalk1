
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
    killer_id = parts[2].to_i
    victim_id = parts[3].chomp(':').to_i
    cause_of_death = parts[4..-1].join(' ')

    # Encontra ou cria os jogadores envolvidos na morte
    killer = Player.find_or_create_by(id: killer_id)
    victim = Player.find_or_create_by(id: victim_id)

    # Cria uma nova instância de Kill associada à partida atual
    current_kill = current_match.kills.create!(
      killer: killer,
      victim: victim,
      cause_of_death: cause_of_death
    )
  end

  def deaths_by_means
    # Cria um hash onde cada causa de morte será uma chave e o valor padrão será 0
    death_counts = Hash.new(0)

    # Percorre cada morte (kill) no conjunto de kills da partida
    self.kills.each do |kill|
      death_cause = kill.cause_of_death
      # Incrementa o contador para a causa de morte específica
      death_counts[death_cause] += 1
    end

    # Retorna o hash com a contagem de mortes por cada causa de morte
    death_counts
  end

  def formatted_deaths_by_means
    # Chama o método deaths_by_means para obter o hash com as contagens
    death_counts = deaths_by_means
    formatted_output = []

    # Para cada causa de morte e sua contagem no hash
    death_counts.each do |cause, count|
      # Formata a saída com a causa de morte e o respectivo número de mortes
      formatted_output << "#{cause}\tContagem: #{count}"
    end

    # Junta as linhas formatadas em uma única string, separada por quebras de linha
    formatted_output.join("\n")
  end
end
