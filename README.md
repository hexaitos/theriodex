# Theriodex – An Open-Source Pokédex Written In Ruby

- [Features (planned and current)](#features-planned-and-current)
  - [Core Pokédex information](#core-pokédex-information)
  - [Advanced Browsing](#advanced-browsing)
  - [Interactive Tools](#interactive-tools)
  - [Customization](#customization)
  - [Planned in the near future](#planned-in-the-near-future)
- [Quick start](#quick-start)
- [Getting sprites and sounds](#getting-sprites-and-sounds)
- [Database information](#database-information)
- [Installation](#installation)
  - [Via source](#via-source)
  - [Via Docker](#via-docker)
    - [Via Codeberg repository](#via-codeberg-repository)
- [Leaderboard](#leaderboard)
- [Reverse proxy](#reverse-proxy)
- [Privacy policy](#privacy-policy)
- [Notes on `rerun`](#notes-on-rerun)
- [Notes on OpenBSD](#notes-on-openbsd)
- [Notes on caching](#notes-on-caching)
- [Acknowledgements](#acknowledgements)
- [Copyright notices and attributions](#copyright-notices-and-attributions)

![Screenshot of Theriodex showing Vaporeon](screenshot.png)

## [![Ruby Version](https://img.shields.io/badge/ruby-3.4.5-red.svg?style=flat-square&logo=ruby)](https://www.ruby-lang.org/) [![License](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg?style=flat-square)](LICENSE) [![Docker](https://img.shields.io/badge/docker-ready-2496ED?style=flat-square&logo=docker)](Dockerfile) [![Codeberg CI](https://ci.codeberg.org/api/badges/15226/status.svg)](https://ci.codeberg.org/hexaitos/theriodex) [![Website](https://img.shields.io/badge/🌐-theriodex.net-green?style=flat-square)](https://theriodex.net)

**Theriodex** is an open-source Pokédex written in Ruby! Displays a random Pokémon with a bunch of information on the homepage but also has information about Pokémons’ moves, their abilties, evolutions and more! It even has a small Pokémon guessing game. It is designed to be reasonably fast, give you the most important information at a glance and work well on both mobile and desktop. Refer to the `TODO.md` file in this repository for more information about what other features are planned. You can try it out over on [theriodex.net](https://theriodex.net)!

This is still very much a work in progress and not done yet, so expect lots of bugs, breakages, maybe incorrect data and frequent updates. The name _Theriodex_ comes from `therio-`, which is a prefix from the Ancient Greek word for "animal" or "beast", and `-dex`, which is a reference to the Pokédex.

This is based off of [PokeAPI](https://github.com/PokeAPI/pokeapi) which, in turn, takes a lot of its data from [Veekun's Pokédex](https://github.com/veekun/pokedex). However, I am not using their API or hosting it myself, I simply built the database which the API uses (`db.sqlite3` in this repository) and am querying it manually from within Ruby.

# Features (planned and current)

## Core Pokédex information

- **(Nearly) Complete Coverage**: All standard 1000+ Pokémon through Generation IX
- **Rich Data**: Base stats, EV yields, catch rates, egg groups, gender ratios, and Pokédex entries
- **Move Learnsets**: Level-up, TM/HM, egg, tutor – with STAB highlighting and with changes per generation!
- **Ability Details**: Full ability descriptions including the Pokémon that can have them
- **Lots of sprites**: Default, shiny, and animated sprites – when looking at the Pokémon of a particular version, the sprite for that version is also shown!

## Advanced Browsing

- **Multi-parameter Filtering**: Browse Pokémon by their type, generation and type and more
- **Item Database**: Complete item listings with descriptions and effects
- **Search**: Fast fuzzy search across Pokémon and moves
- **Multilingual Support**: Interface localization with `lang` parameter support

## Interactive Tools

- **"Who's That Pokémon?" Guessing Game**: Blurred sprite identification with adjustable difficulty
- **Generation Filtering**: Practice specific generations (e.g., "Only Gen 1-3")
- **Global Leaderboard**: Redis-backed score tracking with username persistence

## Customization

- **Typography**: Multiple pixel fonts to choose from depending on your preference
- **Themes**: Different themes – some of which have to be unlocked by playing the game!
- **Cursor Packs**: Various custom CSS cursors
- **View Modes**: Cards vs. table layouts for browsing

## Planned in the near future

- **Evolution Chains**: Visual trees with evolution methods (level, item, friendship, trade, etc.)
- **Daily Challenge Mode**: Wordle-style daily Pokémon (coming soon)
- **Complete Pokédex coverage**: Including variants (like Lycanroc / Oricorio) and mega evolutions etc.
- **Complete and improve localisation**: The current localisation implementation is incomplete and the backend also needs improving

# Quick start

**Prerequisites**

- Docker and Docker Compose installed

Then, to get started simply create a new folder and create a file in that folder titled `docker-compose.yml`. Copy the following text into the file:

```yaml
services:
  theriodex:
    image: codeberg.org/hexaitos/theriodex:latest
    platform: linux/amd64
    ports:
      - "5678:5678"
    environment:
      - REDIS_HOST=redis
    depends_on:
      - redis

  redis:
    image: valkey/valkey:latest
    volumes:
      - redis_data:/data

volumes:
  redis_data:
```

Then start everything by running `(sudo) docker compose up -d`. Wait a while for everything to download. After a short while, Theriodex will be available under `localhost:5678`. If you wish to make it available on the Internet, move down to the
Reverse proxy section

# Getting sprites and sounds

The sprites and cries are fetched not from GitHub but from local storage instead. To use those, place the `sprites` folder from [this](https://github.com/PokeAPI/sprites/tree/4bcd17051efacd74966305ac87a0330b6131259a) repository in the `/public/` folder of this repo. The sprites are pretty large (about 1.5 GB in size).

Please do the same for the `cries` folder from [this](https://github.com/PokeAPI/cries) repository. The cries are much smaller in size, only about 30 MB.

You can, theoretically, use this without any sprites and it _should_ work fine and simply not display the images.

# Database information

No changes have been made to the database and you can also build the database yourself by looking at the instructions in the above-mentioned PokeAPI repository and simply replace the database included herein with your own build - it should work without any problems. However, I am planning on modifying the database at some point and that may require you to run a migration script that will then be included in this repository.

# Installation

This section details the ways you can install and run Theriodex – you can either install it via source or you can run it in a Docker container.

## Via source

Requires Ruby and Bundler. Tested with Ruby `3.4.5`. Run `bundle install` in the cloned repository to download all required gems. Ensure you have placed the `sprites` folder in the correct location as mentioned above (`/public/sprites`). You can then start the server by running `ruby server.rb`.

You may want to run the server in production instead of development mode. To do so, you can start the server by running `APP_ENV=production ruby server.rb`. You may also wish to change the address to which the server listens because, by default, it only listens to `localhost` (so you would be unable to reach the website from anywhere but the machine you are running the server on). To do so, you can add the `-o` flag followed by the IP you wish for the server to listen on. For example, the command `ruby server.rb -o0.0.0.0` would make the server listen to any IP.

You can also start the server in production mode by running `ruby server.rb -e production` – this will also automatically make the server listen to `0.0.0.0`. By default, the server listens to port `4567`. To change the port the server listens to, use the `-p` flag followed by the port as follows: `server.rb -p 8080`.

Updating Theriodex to the latest version should be quite simple: just run a `git pull` command in the directory and restart the server! Alternatively, if you want to run the latest development version, switch to the `dev` branch by running `git checkout dev` and then restarting the server. Updating the dev branch works the same way, simply run `git pull` and then restart. To switch back to the stable version, run `git checkout main` and restart.

## Via Docker

If you wish to run Theriodex via Docker, there are two options: you can either use the pre-built Docker container from the Codeberg Docker repository, or you can build the container yourself using the provided `Dockerfile`. Please follow the instructions on how to install Docker on your Linux distribution of choice – it should work on macOS too!

### Via Codeberg repository

Once you have installed Docker, you should be able to run the following command to start Theriodex on your machine.

```bash
(sudo) docker run \
  --name theriodex \
  -e REDIS_HOST=REDIS_HOST_HERE \
  -p 5678:5678 \
  -d \
  codeberg.org/hexaitos/theriodex:latest
```

Once you have done so, Theriodex will run on `localhost:5678`. The docker container is `amd64`.

## Leaderboard

Theriodex comes with a small leaderboard that allows users to save their game data (from the Pokémon guessing game) in a Redis / Valkey database. Entries are saved into the sorted set `score` with the username in the following format: `ABC-20250911143250>123001238592` wherein the string after `-` is the date and time of the submission and the string after `>` is a randomly generated hash.

To specify the host of the Redis database, you need to set the environment variable `REDIS_HOST` to the correct value. For example, if the database is running on the same machine as Theriodex, you can do the following: `REDIS_HOST="localhost" ruby server.rb -e production`.

## Reverse proxy

To make your version of Theriodex publically accessible, you will most likely want to put it behind a reverse proxy. My preferred method of doing so is by using Caddy, as it makes the whole process rather simple! Let us assume that you have a server or other device which has a public IP and which is currently not hosting anything else – ports 80 and 443 are available and open to the public; let us also assume that you own the domain `theriodex.net` and have entered your servers public IP addresses into your domain registrar so that `theriodex.net` points to the public IP address(es) of your server. You can, then, simply install Caddy and use the following configuration assuming that you use the default port of `5678`:

```Caddyfile
theriodex.net {
	reverse_proxy localhost:5678
	encode zstd gzip
}
```

Caddy will automatically obtain an SSL certificate for you and in just a few moments, your website should be available under `theriodex.net` and have HTTPS enabled!

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

# Acknowledgements

I want to thank the folk behind [PokeAPI](https://github.com/PokeAPI/pokeapi) and [Veekun’s Pokédex](https://github.com/veekun/pokedex) who are responsible for the data in this repository’s database. Thanks also to [GGBotNet](https://www.ggbot.net/) and [VEXED](https://v3x3d.itch.io/) for creating the fantastic pixel fonts I am using. Icons are from [Iconoir](https://iconoir.com/).

A special and immense thanks also to all my partners – who are way better at programming and database queries than I am – for helping me out a lot and answering my questions and giving helpful tips. I definitely would not have been able to get as far with this project if it hadn’t been for them. Thanks 🩵

If you enjoy any of the fonts or icons and wish to use them yourself, please do consider not simply taking them from Theriodex, but going to their respective sites and either buying it from them or donating to them – just as I did, too.

# Copyright notices and attributions

Pokémon and Pokémon character names are trademarks of Nintendo, Game Freak, and Creatures Inc. Theriodex not affiliated with, authorised, or endorsed by The Pokémon Company, Game Freak, Creatures, or Nintendo.

The rest of this project is licensed under the [3-Clause BSD licence](https://opensource.org/license/bsd-3-clause). The main font used on by Theriodex (Logic Loop) is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) and was made by [VEXED](https://v3x3d.itch.io/). A few glyphs are from [GGBotNet](https://www.ggbot.net/)'s Pixeloid font which is licensed under [CC0](https://creativecommons.org/public-domain/cc0/). Icons are from [Iconoir](https://iconoir.com/) and licensed under the MIT license.

---

![Theriodex 88x31 button](public/button_theriodex.gif)

![CI Status](https://ci.codeberg.org/api/badges/15226/status.svg)
