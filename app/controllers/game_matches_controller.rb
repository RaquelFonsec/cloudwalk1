class GameMatchesController < ApplicationController
  # Ação para exibir a lista de partidas de jogo
  def index
    @game_matches = GameMatch.all
  end

  # Ação para exibir detalhes de uma partida de jogo específica
  def show
    @game_match = GameMatch.find(params[:id])
  end

  # Ação para analisar o arquivo de log do jogo e atualizar a lista de partidas
  def parse_log
    # Define o caminho para o arquivo de log
    log_file_path = Rails.root.join('logs', 'game.log')

    # Chama o método estático `parse_log` da classe GameMatch para analisar o arquivo de log
    GameMatch.parse_log(log_file_path)

    # Atualiza a lista de partidas
    @game_matches = GameMatch.all

    # Define a última partida analisada como a partida atual a ser exibida
    @game_match = @game_matches.last

    # Renderiza a página de índice (lista de partidas) após a análise do log
    render :index
  end
end

