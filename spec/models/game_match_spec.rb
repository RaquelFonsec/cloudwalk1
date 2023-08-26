require 'rails_helper'

RSpec.describe GameMatch, type: :model do
  log_file_path = Rails.root.join('logs', 'game.log')

  describe "parsing the log file" do
    it "creates matches and kills" do
      # Verifica se o arquivo de log existe e pode ser lido
      expect(File.exist?(log_file_path)).to be(true)

      # Itera pelas linhas do arquivo de log
      current_match = nil

      File.open(log_file_path, 'r').each_line do |line|
        if line.include?('InitGame:')
          # Inicia uma nova partida quando encontra 'InitGame:'
          current_match = GameMatch.create
        elsif line.include?('Kill:')
          # Analisa a linha de morte quando encontra 'Kill:'
          GameMatch.parse_kill_line(line, current_match) if current_match
          current_match.save if current_match
        end
      end
      expected_number_of_matches = 1
      expected_number_of_kills = 94

      expect(GameMatch.count).to eq(expected_number_of_matches)
      expect(Kill.count).to eq(expected_number_of_kills)

    end
  end
end
describe '#formatted_deaths_by_means' do
  it 'formats death counts by means correctly' do
    # Cria uma instância de GameMatch sem salvar no banco de dados
    game_match = GameMatch.new

    # Cria objetos "stub" de Kill para simular o comportamento
    # sem interação com o banco de dados
    railgun_kill = instance_double(Kill, cause_of_death: 'MOD_RAILGUN')
    shotgun_kill = instance_double(Kill, cause_of_death: 'MOD_SHOTGUN')

    # Simula a associação entre GameMatch e as instâncias de Kill
    allow(game_match).to receive_message_chain(:kills, :each).and_yield(railgun_kill).and_yield(shotgun_kill)

    # Chama o método que está sendo testado
    formatted_output = game_match.formatted_deaths_by_means

    # Verifica se a saída formatada está correta
    expect(formatted_output).to include('MOD_RAILGUN')
    expect(formatted_output).to include('MOD_SHOTGUN')
    expect(formatted_output).to include('Contagem: 1')
  end
end
