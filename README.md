# Bowling API

This API provides some basic services for a standard bowling game.

* Rails 5.1.4 has been used with ruby 2.3.1 and gem 2.6.13

* For testing this rspec and factory_girl has been used (with shoulda-matchers and faker) and additionally the database_cleaner.

* Finally, in order to show information from multiple models, active_model_serializers has been used.

* To run tests:

   * bundle exec rspec

* You may need previously to declare environment for testing:
   
   * bin/rails db:migrate RAILS_ENV=test
