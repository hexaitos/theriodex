# Theriodex
This is just a silly thing I am working on and I am not even entirely sure what the scope will end up being. It displays a random Pokémon with some details on the homepage and has a fuzzy search so you can search for and display the information for a particular Pokémon. Refer to the `TODO` section of this README for more information about what other features are planned. You can try it out over on [dex.btlr.sh](https://dex.btlr.sh).

Very much a work in progress and not done yet. I am not sure about the name yet, but I quite like the name `Theriodex` so far, wherein `therio-` is a prefix from the Ancient Greek word for "animal" or "beast" and `-dex` is a reference to the Pokédex. Name is subject to change, however.

This is based off of [PokeAPI](https://github.com/PokeAPI/pokeapi) which, in turn, takes a lot of its data from [Veekun's Pokédex](https://github.com/veekun/pokedex). However, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby. In addition, the sprites are fetched not from GitHub but from locally stored sprites. To use those, place the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `/public/` folder of this repo. The sprites are pretty large (about 1.5 GB in size) and I did not want to include all that in this repo. No changes have been made to the database and you can also build the database yourself by looking at the instructions in the above-mentioned PokeAPI repository and simply replace the database included herein with your own build - it should work without any problems.

# Installation
Requires Ruby and Bundler. Tested with Ruby `3.4.4`. Run `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above (`/public/sprites`). You can then start the server by running `ruby server.rb`.

You may want to run the server in production instead of development mode. To do so, you can start the server by running `APP_ENV=production ruby server.rb`. You may also wish to change the address to which the server listens because, by default, it only listens to `localhost` (so you would be unable to reach the website from anywhere but the machine you are running the server on). To do so, you can add the `-o` flag followed by the IP you wish for the server to listen on. For example, the command `ruby server.rb -o0.0.0.0` would make the server listen to any IP. 

You can also start the server in production mode by running `ruby server.rb -e production` – this will also automatically make the server listen to `0.0.0.0`. 

# TODO / Ideas
Non-exhaustive list, may not all get implemented and other stuff not here may get implemented. 

- [ ] Display names and flavour text in other languages (maybe with a `?lang=` query and a select box)
- [ ] Pit two Pokémon against one another to compare? 
- [ ] Shows moves. Clickable with more info on each move on each click
- [x] Show evolutions (added in `fe4698bfa8`)
- [x] Show shiny sprites (added in `777ddeb95c`)
- [x] Height, weight, genus, species information (added in `44e722b409`)
- [ ] Show abilities
- [x] Show base stats (added in `23481c26f7`)
- [ ] Show even special varieties (like Oricorio baile and its other forms)
- [ ] Edit database so that the GitHub links are replaced with links to local files (and have a script that you can run that automatically adjusts the database generated from PokeAPI)
- [x] Add button to toggle between male and female forms if they exist (added in `d3678fed04`)
- [ ] Ability to show animated sprites if there is one (maybe also with button, maybe display at random)

# Acknowledgements
I want to thank the folk behind [PokeAPI](https://github.com/PokeAPI/pokeapi) and [Veekun's Pokédex](https://github.com/veekun/pokedex) who are responsible for the data in this repository's database.

A special thanks also to all my partners – who are way better at programming and database queries than I am – for helping me out a lot and answering my questions and giving helpful tips. I definitely would not have been able to get as far with this project if it hadn't been for them. Thanks 🩵

# Copyright notice
Pokémon and Pokémon character names are trademarks of Nintendo. The rest of this project is licensed under the [3-Clause BSD Licence](https://opensource.org/license/bsd-3-clause).
