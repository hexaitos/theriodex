# Theriodex – An Open-Source Pokédex Written In Ruby

![Theriodex 88x31 button](/public/button_theriodex.gif)

![CI Status](https://ci.codeberg.org/api/badges/15226/status.svg)

**Theriodex** is an open-source Pokédex written in Ruby! Displays a random Pokémon with a bunch of information on the homepage but also has information about Pokémons’ moves, their abilties, evolutions and more ! It even has a small Pokémon guessing game. Refer to the `TODO` section of this README for more information about what other features are planned. You can try it out over on [theriodex.net](https://theriodex.net)!

This is still very much a work in progress and not done yet, so expect lots of bugs, breakages, maybe incorrect data and frequent updates. The name _Theriodex_ comes from `therio-`, which is a prefix from the Ancient Greek word for "animal" or "beast", and `-dex`, which is a reference to the Pokédex.

This is based off of [PokeAPI](https://github.com/PokeAPI/pokeapi) which, in turn, takes a lot of its data from [Veekun's Pokédex](https://github.com/veekun/pokedex). However, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby.

# Getting sprites and sounds

The sprites and cries are fetched not from GitHub but from local storage instead. To use those, place the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `/public/` folder of this repo. The sprites are pretty large (about 1.5 GB in size).

Please do the same for the `cries` folder from [this](https://github.com/PokeAPI/cries) repository. The cries are much smaller in size, only about 30 MB.

# Database information

No changes have been made to the database and you can also build the database yourself by looking at the instructions in the above-mentioned PokeAPI repository and simply replace the database included herein with your own build - it should work without any problems. However, I am planning on modifying the database at some point and that may require you to run a migration script that will then be included in this repository.

# Installation

Requires Ruby and Bundler. Tested with Ruby `3.4.5`. Run `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above (`/public/sprites`). You can then start the server by running `ruby server.rb`.

You may want to run the server in production instead of development mode. To do so, you can start the server by running `APP_ENV=production ruby server.rb`. You may also wish to change the address to which the server listens because, by default, it only listens to `localhost` (so you would be unable to reach the website from anywhere but the machine you are running the server on). To do so, you can add the `-o` flag followed by the IP you wish for the server to listen on. For example, the command `ruby server.rb -o0.0.0.0` would make the server listen to any IP.

You can also start the server in production mode by running `ruby server.rb -e production` – this will also automatically make the server listen to `0.0.0.0`.

By default, the server listens to port `4567`. To change the port the server listens to, use the `-p` flag followed by the port as follows: `server.rb -p 8080`.

## Leaderboard

Theriodex comes with a small leaderboard that allows users to save their game data (from the Pokémon guessing game) in a Redis / Valkey database. Entries are saved into the sorted set `score` with the username in the following format: `ABC-20250911143250>123001238592` wherein the string after `-` is the date and time of the submission and the string after `>` is a randomly generated hash.

To specify the host of the Redis database, you need to set the environment variable `REDIS_HOST` to the correct value. For example, if the database is running on the same machine as Theriodex, you can do the following: `REDIS_HOST="localhost" ruby server.rb -e production`.

## Privacy policy

This repo includes the privacy policy for my own hosted instance of Theriodex. This will obviously not apply to you, so if you wish to host it yourself, **change the privacy policy under `/views/privacy.md` accordingly**.

If you are using the Docker container, you can overwrite the default privacy policy with your own using a volume: `docker run -e REDIS_HOST="redis_host" -p 5678:5678 -v /path/to/your/custom/privacy.md:/usr/src/app/views/privacy.md theriodex`.

## Notes on `rerun`

Theriodex includes a Ruby gem called `rerun` that will automatically detect if a file has changed and, then, restart the server automatically. This has the advantage that all you will need to do is run `git pull` in the directory you downloaded Theriodex to and it will automatically be updated and you will get the newest version without having to manually restart the server using, for example, `sudo systemctl restart theriodex`.

To use this functionality, you can start Theriodex using a command that looks as follows:

```bash
rerun -- ruby server.rb -e production
```

This will start Theriodex in production mode on the default port with `rerun`.

## Notes on OpenBSD

I generally prefer to use OpenBSD as my server operating system these days. Unfortunately, Ruby has been a little bit annoying when it comes to OpenBSD. This was tested on OpenBSD 7.6 with Ruby 3.3.5 and Bundler 2.6.7 as well as OpenBSD 7.7 with Ruby 3.3.5 and Ruby 3.4.2.

### Nokogiri problems

You should be able to install `bundler` itself without any problems, but when running `bundle install`, you may run into problems with installing `nokogiri`. To solve this, running the following commands should make it work:

```bash
pkg_add libxml libxslt libiconv
bundle config build.nokogiri --use-system-libraries
bundle install
```

### Problem installing gems as non-root

You may also have trouble installing the gems in the repository by running `bundle install` and will get permission errors, as Bundler is unable to write to the directories it wants to write to. A possible fix for this problem is changing the directory that Bundler installs its gems into to something that the current user can access, such as `~/.gem`. To do so, add the following to your `~/.profile`:

```bash
export GEM_HOME=$HOME/.gem
```

You can do so directly by running the following command:

```bash
echo 'export GEM_HOME=$HOME/.gem' >> $HOME/.profile
```

## Notes on caching

I am using [rack-cache](https://github.com/rtomayko/rack-cache) for disk caching. You may wish to remove or adjust it according to your preferences. To do so, check the `/app/helpers/vars.rb` file and change the following variable so that it matches your preference:

```ruby
CACHE_DIR = "/tmp/cache/rack"
```

By default (as can be seen in the code snippet above), Theriodex saves its cache in `/tmp/cache/rack/`. This means that even things like the included `styles.css` or the sprites are cached on disk until they are invalidated. The server should automatically delete the cache whenever it starts. If you do not want this functionality, you can comment out the following line in the `server.rb` file:

```ruby
FileUtils.remove_dir(CACHE_DIR) if Dir.exist?(CACHE_DIR)
```

**Disabling caching**: To disable caching, I would recommend to simply remove everything relating to caching from the `server.rb` file. This includes the above-mentioned code snippet, as well as any lines with `cache_control` in them (such as `cache_control :public, :max_age => 3600`). You should then also remove the `require 'rack/cache'` statement.

You can also simply use the `no_rack_cache` environment. Simply start the server by specifying `server.rb -e no_rack_cache` and the caching will be disabled.

**Memory caching**: You may also wish to cache things in memory instead of on disk. To do so, change the above-mentioned code snippet to the following:

```ruby
use Rack::Cache,
  :metastore => 'heap:/',
  :entitystore => 'heap:/',
  :verbose => true
```

_It is important to note, however_ that `rack-cache`'s memory storage does not feature an automatic purging of unused entries; therefore, the longer the application runs, the more memory it will end up using. This is obviously not a great idea for many reasons, so I would generally advice against doing so unless you are only testing this locally.

Please also check the `rack-cache` [documentation](https://rtomayko.github.io/rack-cache/storage) for further information.

# TODO / Ideas

Non-exhaustive list, may not all get implemented and other stuff not here may get implemented.

- [x] Display names and flavour text in other languages (maybe with a `?lang=` query and a select box) (fully localised as of `636b1aeca2`)
- [ ] Pit two Pokémon against one another to compare?
- [x] Shows moves. Clickable with more info on each move on each click
  - [x] Make it so that each move has its own information page
  - [ ] Target information in move information
  - [ ] When looking at all moves a particular Pokémon of a particular generation learns, show that generation's sprites at the top
  - [ ] Better move overview
  - [ ] Sometimes move differ from game to game in a particular gen (Vaporeon, Gen I). Fix it so that this is properly displayed
  - [ ] In the view showing all Pokémon that can learn a particular move, add the level at which they learn it / the HM/TM by which they learn it
  - [ ] Browsable moves / searchable moves
  - [ ] Maybe add the "Pokémon that can learn this move" stuff into the same view as the move itself?
- [x] Show evolutions (added in `fe4698bfa8`)
- [x] Show shiny sprites (added in `777ddeb95c`)
- [x] Height, weight, genus, species information (added in `44e722b409`)
- [x] Show abilities (added in `3526d228dd`)
- [x] Show base stats (added in `23481c26f7`)
- [ ] Show even special varieties (like Oricorio baile and its other forms)
- [ ] Edit database so that the GitHub links are replaced with links to local files (and have a script that you can run that automatically adjusts the database generated from PokeAPI)
- [x] Add button to toggle between male and female forms if they exist (added in `d3678fed04`)
- [x] Ability to show animated sprites if there is one (maybe also with button, maybe display at random) (added in `f1782528cb`)
- [ ] Clean up index.erb with some helper functions perhaps?
- [x] Add info what generation a Pokémon first appeared in
- [ ] Maybe move language from query param to route (`?lang=de` => `/show/de/:id`)
- [x] Maybe a small game where you have to guess a Pokémon (`image-rendering: pixelated;` and scaling up might work?)
- [x] Maybe add berries?
- [ ] Maybe add characteristic?
- [x] Add cries? (added in `a7946dd1dd`)
- [x] View Pokémon by type
- [x] Show Pokémon by type sorted by generation
- [x] Show Pokémon by generation sorted by type
- [ ] Add more evolution data (time of day, trigger, happiness etc.)
  - [ ] Add mega evolutions

# Acknowledgements

I want to thank the folk behind [PokeAPI](https://github.com/PokeAPI/pokeapi) and [Veekun's Pokédex](https://github.com/veekun/pokedex) who are responsible for the data in this repository's database. Thanks also to [GGBotNet](https://www.ggbot.net/) for creating the fantastic pixel fonts I am using.

A special thanks also to all my partners – who are way better at programming and database queries than I am – for helping me out a lot and answering my questions and giving helpful tips. I definitely would not have been able to get as far with this project if it hadn't been for them. Thanks 🩵

# Copyright notice

Pokémon and Pokémon character names are trademarks of Nintendo. The rest of this project is licensed under the [3-Clause BSD Licence](https://opensource.org/license/bsd-3-clause).
