# TODO / Ideas

Non-exhaustive list, may not all get implemented and other stuff not here may get implemented.

- [x] Display names and flavour text in other languages (maybe with a `?lang=` query and a select box) (fully localised as of `636b1aeca2`)
- [ ] Pit two Pokémon against one another to compare?
- [x] Shows moves. Clickable with more info on each move on each click
  - [x] Make it so that each move has its own information page
  - [ ] Target information in move information
  - [x] When looking at all moves a particular Pokémon of a particular generation learns, show that generation's sprites at the top
  - [x] Better move overview
  - [x] Sometimes move differ from game to game in a particular gen (Vaporeon, Gen I). Fix it so that this is properly displayed
  - [ ] In the view showing all Pokémon that can learn a particular move, add the level at which they learn it / the HM/TM by which they learn it
  - [ ] Browsable moves / searchable moves
  - [x] Maybe add the "Pokémon that can learn this move" stuff into the same view as the move itself?
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
