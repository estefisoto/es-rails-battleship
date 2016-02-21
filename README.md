
Battleship Game
================

Dependencies
--------------
* Ruby version: ruby-2.2.4

* The bundler ruby gem to manage the rest of the gem dependencies.
	`$ gem install bundler`

* Database used is PostgresSQL , setup of Postgres can be found online, here is [one][postgres]
	`$ gem install pg`
 
* Pub/sub for player action uses [Private Pub][private_pub] a gem that provides a mechanism to publish and subscribe to 'channels' through Faye.Private Pub allows you to quickly and easily set up the Faye server and connect it to your app and provides a series of helper methods to subscribe/publish to channels and set up a websocket for bidirectional communication.
The [alternative usage][alternate] was implemented for this project

[private_pub]:https://github.com/ryanb/private_pub
[alternate]:https://github.com/ryanb/private_pub#alternative-usage 
[postgres]:https://www.digitalocean.com/community/tutorials/how-to-setup-ruby-on-rails-with-postgres

Setup
-----

1.  Run the following commands from the application directory:
	`$ bundle install`

2. Edit your database.yml
    By default, the database uses the default role which is the same name as the operating system user that initialized the database. If you already have a role or want to create a new role update database.yml and set your username and password

3. Create database
	`$ rake db:create`

4. Migrate databse - seed is not needed games, players are created on the fly when user starts new game
	`$ rake db:migrate`

5. Very important step! So that communication (web socket) for play action is set up start rack Faye server , default port for thin is 9292 to change port update the private pub config (private_pub.yml). Start server by running 
 	`$ rackup private_pub.ru -s thin -E production`
	Use option -p if using another port
	`$ rackup private_pub.ru -s thin -E production -p 9999`
	
6. Start the server
	`$ rails s`

7. Open browser and navigate to http://localhost:3000/play