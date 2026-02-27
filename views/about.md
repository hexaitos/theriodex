# About Theriodex

![](/button_theriodex.gif)

**Theriodex** is an open-source Pokédex written in Ruby using [Sinatra](https://sinatrarb.com) and a handful of other Ruby gems. It is – and will remain – completely ad-free and non-commercial! Its aim is to provide you with the most important information you need at a glance! Also try the [Who's That Pokémon?](/game) guessing game and unlock more customisation options you can apply in the [Settings](/settings)!

It started out as a small project of mine but has tured into something much bigger! It is now the by far biggest project I have ever worked on and written myself and new features and bug fixes are still being added frequently! This is, however, very much a passion project and a programming excercise and, therefore, things have absolutely not been written or done in the most optimal of manners.

I highly recommend checking out this project’s official [git repository](https://codeberg.org/hexaitos/theriodex), as you will be able to find the project’s README there which contains a bunch of planned features as well as instructions on how to run this yourself, if you so wish.

---

## Features

### Core Pokédex Information and Features

- **(Nearly) Complete Coverage**: All standard 1000+ Pokémon through Generation IX
- **Damage information**: Quick overview of how much damage a Pokémon receives from other types! Takes dual-type Pokémon into account
- **Move Learnsets**: Level-up, TM/HM, egg, and tutor moves with STAB highlighting and generation-specific changes
- **Ability Details**: Full ability descriptions including which Pokémon can have them
- **Stats and evolutions**: Overview of Pokémon's base stats and all their evolutions
- **Lots and lots of sprites**: Default, shiny, and animated sprites and even version-specific sprites when viewing Pokémon by game version!
- **Random Pokémon**: Displays a random Pokémon every time you visit the start page!

### Advanced Browsing

- **Multi-parameter Filtering**: Browse by type, generation, and more
- **Item Database**: Complete item listings with descriptions and effects
- **Search**: Fast fuzzy search across Pokémon and moves
- **Multilingual Support**: Interface localization with `lang` parameter support

### Guessing Game

- **"Who's That Pokémon?" Guessing Game**: Blurred sprite identification with adjustable difficulty
- **Generation Filtering**: Practise specific generations (e.g., "Only Gen 3")
- **Global Leaderboard**: Redis-backed score tracking with username persistence

### Customisation

- **Typography**: Multiple pixel fonts to choose from
- **Themes**: Various themes (some unlockable via gameplay)
- **Cursor Packs**: Various custom CSS cursors
- **View Modes**: Cards vs. table layouts for browsing

### Planned Features

- **Evolution Chains**: Visual trees with evolution methods (level, item, friendship, trade, etc.)
- **Daily Challenge Mode**: Wordle-style daily Pokémon challenge
- **Complete Coverage**: Including variants (Lycanroc, Oricorio) and Mega Evolutions
- **Improved Localization**: Completing the current implementation and working on moving over to another backend

---

## Acknowledgements

I want to thank the folk behind [PokeAPI](https://github.com/PokeAPI/pokeapi) and [Veekun’s Pokédex](https://github.com/veekun/pokedex) who are responsible for the data in this repository’s database. Thanks also to [GGBotNet](https://www.ggbot.net/) and [VEXED](https://v3x3d.itch.io/) for creating the fantastic pixel fonts I am using. Icons are from [Iconoir](https://iconoir.com/).

A special and immense thanks also to all my partners – who are way better at programming and database queries than I am – for helping me out a lot and answering my questions and giving helpful tips. I definitely would not have been able to get as far with this project if it hadn’t been for them. Thanks 🩵

If you enjoy any of the fonts or icons and wish to use them yourself, please do consider not simply taking them from Theriodex, but going to their respective sites and either buying it from them or donating to them – just as I did, too.

---

## Tech

Theriodex is powered – in one way or another – by OpenBSD, Debian, Docker, Netcup, deSEC and Codeberg! We are, therefore, essentially fully hosted in Germany!

I used to mainly write my code in Doom Emacs but moved to VS Code and now mostly Zed mostly either on Linux (Fedora on my Framework 12) or macOS (on my M4 MacBook Pro).

---

## Copyright notices and attributions

Pokémon and Pokémon character names are trademarks of Nintendo, Game Freak, and Creatures Inc. Theriodex is not affiliated with, authorized, or endorsed by The Pokémon Company, Game Freak, Creatures, or Nintendo.

The project is licensed under the [3-Clause BSD License](https://opensource.org/license/bsd-3-clause).

- **Fonts** (all fonts selectable in the `Settings`): [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) by [VEXED](https://v3x3d.itch.io/)
- **Pixeloid font** (glyphs): [CC0](https://creativecommons.org/public-domain/cc0/) by [GGBotNet](https://www.ggbot.net/)
- **Icons**: MIT License by [Iconoir](https://iconoir.com/)
