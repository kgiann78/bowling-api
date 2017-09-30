# Bowling API

This API provides some basic services for a standard bowling game.

* Rails 5.1.4 has been used with ruby 2.3.1 and gem 2.6.13

* For testing this rspec and factory_girl has been used (with shoulda-matchers and faker) and additionally the database_cleaner.

* Finally, in order to show information from multiple models, active_model_serializers has been used.

* To run tests:

   * bundle exec rspec

* You may need previously to declare environment for testing:
   
   * bin/rails db:migrate RAILS_ENV=test


The following endpoints are available:

* Game endpoints
    * GET /games - gets all games and their players
    * GET /games/id - gets specific game and the players that are participating in that game
    * POST /games - adds a new game (json schema example for game { "lane":1 })
    * PUT /games/id - update a specific game
    * DELETE /games/id - deletes a specific game
* Player endpoints
    * GET /games/game_id/Players - gets all players for a specific game and their frames
    * GET /games/:game_id/players/id - gets specific player and all of his/her frames of a specific game
    * POST /games/:game_id/players - adds a new player to a specific game (json schema example for player { "name":"Alex", "score":0 })
