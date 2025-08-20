# Theriodex
This is just a silly thing I am working on and I am not even entirely sure what the scope will end up being. It displays a random Pokémon with some details on the homepage and has a fuzzy search so you can search for and display the information for a particular Pokémon. Refer to the `TODO` section of this README for more information about what other features are planned. You can try it out over on [dex.btlr.sh](https://dex.btlr.sh).

Very much a work in progress and not done yet. I am not sure about the name yet, but I quite like the name `Theriodex` so far, wherein `therio-` is a prefix from the Ancient Greek word for "animal" or "beast" and `-dex` is a reference to the Pokédex. Name is subject to change, however.

This is based off of [PokeAPI](github.com/PokeAPI/pokeapi) which, in turn, takes a lot of its data from [Veekun's Pokédex](https://github.com/veekun/pokedex). However, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby. In addition, the sprites are fetched not from GitHub but from locally stored sprites. To use those, place the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `/public/` folder of this repo. The sprites are pretty large (about 1.5 GB in size) and I did not want to include all that in this repo. No changes have been made to the database and you can also build the database yourself by looking at the instructions in the above-mentioned PokeAPI repository and simply replace the database included herein with your own build - it should work without any problems.

# Installation
Requires Ruby and Bundler. Tested with Ruby `3.4.4`. Run `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above (`/public/sprites`). You can then start the server by running `ruby server.rb`.

You may want to run the server in production instead of development mode. To do so, you can start the server by running `APP_ENV=production ruby server.rb`. You may also wish to change the address to which the server listens because, by default, it only listens to `localhost` (so you would be unable to reach the website from anywhere but the machine you are running the server on). To do so, you can add the `-o` flag followed by the IP you wish for the server to listen on. For example, the command `ruby server.rb -o0.0.0.0` would make the server listen to any IP. 

# TODO / Ideas
Non-exhaustive list, may not all get implemented and other stuff not here may get implemented. 

- [ ] Display names and flavour text in other languages (maybe with a `?lang=` query and a select box)
- [ ] Pit two Pokémon against one another to compare? 
- [ ] Shows moves. Clickable with more info on each move on each click
- [ ] Show evolutions
- [ ] Show shiny sprites

# Copyright notice
Pokémon and Pokémon character names are trademarks of Nintendo. The rest of this project is licensed under the [3-Clause BSD Licence](https://opensource.org/license/bsd-3-clause).
