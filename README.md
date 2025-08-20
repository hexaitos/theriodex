# Pokémon Website – Theriodex
This is just a silly thing I am working on and I am not even entirely sure what the scope will end up being. Very much a work in progress and not done yet. I am not sure about the name yet, but I quite like `Theriodex` so far with `therio-` being a prefix from the Ancient Greek word for "animal" or "beast" and `-dex` obviously referring to the Pokédex. Name is subject to change, however!

This is based off of github.com/PokeAPI/pokeapi; however, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby. In addition, the sprites are fetched not from GitHub but from locally stored sprites. To use those, places the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `assets/` folder of this repo. The sprites are pretty large (about 1.5 GB in size) and I did not want to include all that in this repo. 

Requires Ruby and Bundler. Ruby `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above. You can then start the server by running `ruby server.rb`.

# TODO / Ideas
Non-exhaustive list, may not all get implemented and other stuff not here may get implemented. 

- [ ] Display names and flavour text in other languages (maybe with a `?lang=` query and a select box)
- [ ] Pit two Pokémon against one another to compare? 
- [ ] Shows moves. Clickable with more info on each move on each click
- [ ] Show evolutions
- [ ] Show shiny sprites

# Copyright notice
Pokémon and Pokémon character names are trademarks of Nintendo.
