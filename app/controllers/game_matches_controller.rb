
class GameMatchesController < ApplicationController
  def index
    @game_matches = GameMatch.all
  end

  def show
    @game_match = GameMatch.find(params[:id])
  end

  def parse_log
    log_file_path = Rails.root.join('logs', 'game.log')
    GameMatch.parse_log(log_file_path)
    redirect_to game_matches_path, notice: 'Log parsed successfully.'
  end
end
