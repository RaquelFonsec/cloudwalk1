# README

# Quake Log Analyzer

Welcome to the Quake Log Analyzer! This project provides a tool to analyze Quake 3 Arena game log files, extract game data, and generate comprehensive match reports. These reports include information about total kills, player rankings, and causes of death for each match.

## Features

- Read and analyze Quake 3 Arena game log files.
- Generate match reports with grouped kill data and player rankings.
- Identify causes of death based on the provided enum.
- Gain insights into player performance and match statistics.

## Installation

1. Clone the repository:
git clone https://github.com/RaquelFonsec/cloudwalk1.git

2. Navigate to the project directory:
cd cloudwalk1


3. Install the required Ruby gems by running:
   bundle install


4. Run the database migrations to set up the necessary database schema:
 rails db:migrate

5. Execute the log analysis script by running the following command:

ruby bin/analyze_log.rb logs/game.log

 The script will process the log file and generate match reports in the terminal.


Sample output of the script execution:

Match: 1
Total Kills: 45

Players:

ball owner
Isgalamido
Zeh
Kills:

ball owner: 5 kills
Isgalamido: 18 kills
Zeh: 20 kills
Causes of Death:
MOD_SHOTGUN Count: 10
MOD_RAILGUN Count: 2
MOD_GAUNTLET Count: 1


## Contributing

Contributions are welcome! If you find any issues or have suggestions, feel free to open an issue or a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
