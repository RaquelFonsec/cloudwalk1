
# analyze_log.rb

require_relative '../config/environment'

def generate_match_report(game_match)
  match_report = {
    "total_kills" => game_match.kills.count,
    "players" => game_match.players.pluck(:name),
    "kills" => Hash.new(0)
  }

  game_match.kills.each do |kill|
    match_report["kills"][kill.killer.name] += 1 unless kill.killer == kill.victim
  end

  match_report
end

GameMatch.all.each do |game_match|
  match_report = generate_match_report(game_match)

  puts "Match: #{game_match.id}"
  puts "------------------"
  puts "Total Kills: #{match_report['total_kills']}"

  puts "\nPlayers:"
  match_report['players'].each do |player|
    puts "- #{player}"
  end

  puts "\nKills:"
  match_report['kills'].each do |player, kills|
    puts "- #{player}: #{kills} kills"
  end

  puts "\nDeaths by Cause:"
  game_match.formatted_deaths_by_means.each_line do |line|
    puts line
  end

  puts "\n"
end
