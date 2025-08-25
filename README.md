# Theriodex

![Theriodex 88x31 button](/public/button_theriodex.gif)

This is just a silly thing I am working on and I am not even entirely sure what the scope will end up being. It displays a random Pokémon with some details on the homepage and has a fuzzy search so you can search for and display the information for a particular Pokémon. Refer to the `TODO` section of this README for more information about what other features are planned. You can try it out over on [dex.btlr.sh](https://dex.btlr.sh).

Very much a work in progress and not done yet. I am not sure about the name yet, but I quite like the name `Theriodex` so far, wherein `therio-` is a prefix from the Ancient Greek word for "animal" or "beast" and `-dex` is a reference to the Pokédex. Name is subject to change, however.

This is based off of [PokeAPI](https://github.com/PokeAPI/pokeapi) which, in turn, takes a lot of its data from [Veekun's Pokédex](https://github.com/veekun/pokedex). However, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby. In addition, the sprites are fetched not from GitHub but from locally stored sprites. To use those, place the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `/public/` folder of this repo. The sprites are pretty large (about 1.5 GB in size) and I did not want to include all that in this repo. No changes have been made to the database and you can also build the database yourself by looking at the instructions in the above-mentioned PokeAPI repository and simply replace the database included herein with your own build - it should work without any problems.

# Installation
Requires Ruby and Bundler. Tested with Ruby `3.4.4`. Run `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above (`/public/sprites`). You can then start the server by running `ruby server.rb`.

You may want to run the server in production instead of development mode. To do so, you can start the server by running `APP_ENV=production ruby server.rb`. You may also wish to change the address to which the server listens because, by default, it only listens to `localhost` (so you would be unable to reach the website from anywhere but the machine you are running the server on). To do so, you can add the `-o` flag followed by the IP you wish for the server to listen on. For example, the command `ruby server.rb -o0.0.0.0` would make the server listen to any IP. 

You can also start the server in production mode by running `ruby server.rb -e production` – this will also automatically make the server listen to `0.0.0.0`. 

## Notes on OpenBSD
I generally prefer to use OpenBSD as my server operating system these days. Unfortunately, Ruby has been a little bit annoying when it comes to OpenBSD. You should be able to install `bundler` itself without any problems, but when running `bundle install`, you may run into problems with installing `nokogiri`. To solve this, running the following commands should make it work: 

```bash
pkg_add libxml libxslt libiconv
bundle config build.nokogiri --use-system-libraries
bundle install
```

This was tested on OpenBSD 7.6 with Ruby 3.3.5 and Bundler 2.6.7. I will still have to test it on 7.7, but I presume it will be similar there. 

## Notes on caching
I am using [rack-cache](https://github.com/rtomayko/rack-cache) for disk caching. You may wish to remove or adjust it according to your preferences. To do so, check the `server.rb` file and change the following lines so that they match your preferences: 

```ruby
use Rack::Cache,
	:metastore => 'file:/tmp/cache/rack/meta',
	:entitystore => 'file:/tmp/cache/rack/body',
	:verbose => true
``` 

By default (as can be seen in the code snippet above), Theriodex saves its cache in `/tmp/cache/rack/`. This means that even things like the included `styles.css` or the sprites are cached on disk until they are invalidated. Thus, if you update Theriodex, you may stil have an old version of the `styles.css` or other files cached. Thus, I recommend always deleting everything in `/tmp/cache/rack/` after an update. 

**Disabling caching**: To disable caching, I would recommend to simply remove everything relating to caching from the `server.rb` file. This includes the above-mentioned code snippet, as well as any lines with `cache_control` in them (such as `cache_control :public, :max_age => 3600`). You should then also remove the `require 'rack/cache'` statement. 

**Memory caching**: You may also wish to cache things in memory instead of on disk. To do so, change the above-mentioned code snippet to the following: 

```ruby
use Rack::Cache,
  :metastore => 'heap:/',
  :entitystore => 'heap:/',
  :verbose => true
```

*It is important to note, however* that `rack-cache`'s memory storage does not feature an automatic purging of unused entries; therefore, the longer the application runs, the more memory it will end up using. This is obviously not a great idea for many reasons, so I would generally advice against doing so unless you are only testing this locally.

Please also check the `racke-cache` [documentation](https://rtomayko.github.io/rack-cache/storage) for further information.

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
- [x] Ability to show animated sprites if there is one (maybe also with button, maybe display at random) (added in `f1782528cb`)
- [ ] Clean up index.erb with some helper functions perhaps? 

# Acknowledgements
I want to thank the folk behind [PokeAPI](https://github.com/PokeAPI/pokeapi) and [Veekun's Pokédex](https://github.com/veekun/pokedex) who are responsible for the data in this repository's database.

A special thanks also to all my partners – who are way better at programming and database queries than I am – for helping me out a lot and answering my questions and giving helpful tips. I definitely would not have been able to get as far with this project if it hadn't been for them. Thanks 🩵

# Copyright notice
Pokémon and Pokémon character names are trademarks of Nintendo. The rest of this project is licensed under the [3-Clause BSD Licence](https://opensource.org/license/bsd-3-clause).
