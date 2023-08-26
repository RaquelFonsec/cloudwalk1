require 'rails_helper'

RSpec.describe GameMatchesController, type: :controller do
  describe "GET show" do
    it "returns http success" do
      # Crie um novo objeto GameMatch e salve-o no banco de dados
      game_match = GameMatch.create!(name: "Sample Game", score: 100)

      # Chame a ação 'show' e passe o ID do objeto criado
      get :show, params: { id: game_match.id }

      # Verifique se a resposta é bem-sucedida (HTTP status 200)
      expect(response).to have_http_status(:success)
    end
  end
end


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
