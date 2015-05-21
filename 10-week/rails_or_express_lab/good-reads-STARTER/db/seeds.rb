Book.destroy_all

Book.create([
  {:title=>"The Great Gatsby",
  :author=>"F. Scott Fitzgerald",
  :image=> "http://ecx.images-amazon.com/images/I/41eiFf1x23L._SL160_.jpg",
  :first_words=>
   "\"In my younger and more vulnerable years my father gave me some advice that I've been turning over in my mind ever since.\""},
 {:title=>"The Grapes of Wrath",
  :author=>"John Steinbeck",
  :image=> "http://ecx.images-amazon.com/images/I/41adOkkXUzL._SL160_.jpg",
  :first_words=>
   "\"To the red country and part of the gray country of Oklahoma, the last rains came gently, and they did not cut the scarred earth.\""},
 {:title=>"Nineteen Eighty-Four",
  :author=>"George Orwell",
  :image=> "http://ecx.images-amazon.com/images/I/41Kv1qGuXUL._SL160_.jpg",
  :first_words=>"\"It was a bright cold day in April, and the clocks were striking thirteen.\""},
 {:title=>"Ulysses",
  :author=>"James Joyce",
  :image=> "http://ecx.images-amazon.com/images/I/51XEH13NOnL._SL160_.jpg",
  :first_words=>
   "\"Stately, plump Buck Mulligan came from the stairhead, bearing a bowl of lather on which a mirror and a razor lay crossed.\""},
 {:title=>"Lolita",
  :author=>"Vladimir Nabokov",
  :image=> "http://ecx.images-amazon.com/images/I/41gMT3BaWiL._SL160_.jpg",
  :first_words=>
   "\"Lolita, light of my life, fire of my loins. My sin, my soul. Lo-lee-ta: the tip of the tongue taking a trip of three steps down the palette to tap, at three, on the teeth.\""},
 {:title=>"Catch-22",
  :author=>"Joseph Heller",
  :image=> "http://ecx.images-amazon.com/images/I/51kqbC3YKvL._SL160_.jpg",
  :first_words=>"\"It was love at first sight.\""},
 {:title=>"The Catcher in the Rye",
  :author=>"J. D. Salinger",
  :image=> "http://ecx.images-amazon.com/images/I/511BDFArolL._SL160_.jpg",
  :first_words=>
   "\"If you really want to hear about it, the first thing you'll probably want to know is where I was born, and what my lousy childhood was like, and how my parents were occupied and all before they..."},
 {:title=>"Beloved",
  :author=>"Toni Morrison",
  :image=> "http://ecx.images-amazon.com/images/I/31BhkmDS75L._SL160_.jpg",
  :first_words=>"\"124 was spiteful. Full of baby's venom. The women in the house knew it and so did the children.\""},
 {:title=>"The Sound and the Fury",
  :author=>"William Faulkner",
  :image=> "http://ecx.images-amazon.com/images/I/51wiIwgg8yL._SL160_.jpg",
  :first_words=>"\"Through the fence, between the curling flower spaces, I could see them hitting.\""},
 {:title=>"To Kill a Mockingbird",
  :author=>"Harper Lee",
  :image=>
   "http://ecx.images-amazon.com/images/I/51KFyfyK7eL._SL160_.jpg",
  :first_words=>"\"When he was nearly thirteen, my brother Jem got his arm badly broken at the elbow.\""},
  {:title=>"The Lord of the Rings",
  :author=>"J. R. R. Tolkien",
  :image=> "http://ecx.images-amazon.com/images/I/516GyHY9p6L._SL160_.jpg",
  :first_words=>
   "\"When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton.\""},
 {:title=>"One Hundred Years of Solitude",
  :author=>"Gabriel García Márquez",
  :image=> "http://ecx.images-amazon.com/images/I/513GEHVNTBL._SL160_.jpg",
  :first_words=>
   "\"Many years later, as he faced the firing squad, Colonel Aureliano Buendía was to remember that distant afternoon when his father took him to discover ice.Muchos años después, frente al pelotón de...\""},
 {:title=>"Brave New World",
  :author=>"Aldous Huxley",
  :image=>
   "http://ecx.images-amazon.com/images/I/41kwa0ECKKL._SL160_.jpg",
  :first_words=>"\"A squat grey building of only thirty-four stories.\""},
 {:title=>"To the Lighthouse",
  :author=>"Virginia Woolf",
  :image=> "http://ecx.images-amazon.com/images/I/41jK9O4kcbL._SL160_.jpg",
  :first_words=>
   "\"Yes, of course, if it's fine tomorrow,\" said Mrs. Ramsay. \"But you'll have to be up with the lark,\" she added."},
 {:title=>"Invisible Man",
  :author=>"Ralph Ellison",
  :image=> "http://ecx.images-amazon.com/images/I/41RYVHiPOdL._SL160_.jpg",
  :first_words=>
   "\"I am an invisible man. No, I am not a spook like those who haunted Edgar Allan Poe; nor am I one of your Hollywood-movie ectoplasms. I am a man of substance, of flesh and bone, fiber and liquids—..."},
 {:title=>"Gone with the Wind",
  :author=>"Margaret Mitchell",
  :image=> "http://ecx.images-amazon.com/images/I/51OzjjUS28L._SL160_.jpg",
  :first_words=>
   "\"Scarlett O'Hara was not beautiful, but men seldom realized it when caught by her charm, as the Tarleton twins were.\""},
 {:title=>"Jane Eyre",
  :author=>"Charlotte Brontë",
  :image=> "http://ecx.images-amazon.com/images/I/51BcQQaBU8L._SL160_.jpg",
  :first_words=>
   "\"There was no possibility of taking a walk that day. We had been wandering, indeed, in the leafless shrubbery an hour in the morning; but since dinner (Mrs. Reed, when there was no company, dined...\""},
 {:title=>"On the Road",
  :author=>"Jack Kerouac",
  :image=> "http://ecx.images-amazon.com/images/I/51nr10ChxRL._SL160_.jpg",
  :first_words=>"\"I first met Dean not long after my wife and I split up.\""},
 {:title=>"Pride and Prejudice",
  :author=>"Jane Austen",
  :image=> "http://ecx.images-amazon.com/images/I/51esDUk1Q6L._SL160_.jpg",
  :first_words=>
   "\"It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.\""},
 {:title=>"Lord of the Flies",
  :author=>"William Golding",
  :image=> "http://ecx.images-amazon.com/images/I/51rgMeqmqaL._SL160_.jpg",
  :first_words=>
   "\"The boy with fair hair lowered himself down the last few feet of rock and began to pick his way toward the lagoon.\""},
  {:title=>"Middlemarch",
  :author=>"George Eliot",
  :image=> "http://ecx.images-amazon.com/images/I/41zlaqR61LL._SL160_.jpg",
  :first_words=>
   "\"Who that cares much to know the history of man, and how the mysterious mixture behaves under the varying experiments of Time, has not dwelt, at least briefly, on the life of Saint Theresa, has not...\""},
 {:title=>"Anna Karenina",
  :author=>"Leo Tolstoy",
  :image=> "http://ecx.images-amazon.com/images/I/41OgCEpxFeL._SL160_.jpg",
  :first_words=>
   "\"Happy families are all alike; every unhappy family is unhappy in its own way. (C. Garnett, 1946) and (J. Carmichael, 1960)All happy families resemble one another, but each unhappy family is unhappy...\""},
 {:title=>"Animal Farm",
  :author=>"George Orwell",
  :image=> "http://ecx.images-amazon.com/images/I/41QRF64o9%2BL._SL160_.jpg",
  :first_words=>
   "\"Mr. Jones, of the Manor Farm, had locked the hen-houses for the night, but was too drunk to remember to shut the popholes.\""},
 {:title=>"A Passage to India",
  :author=>"E. M. Forster",
  :image=> "http://ecx.images-amazon.com/images/I/51A0TB5B0RL._SL160_.jpg",
  :first_words=>
   "\"Except for the Marabar caves--and they are twenty miles off--the city of Chrandrapore presents nothing extraordinary.\""},
 {:title=>"In Search of Lost Time",
  :author=>"Marcel Proust",
  :image=> "http://ecx.images-amazon.com/images/I/51X2KB62J8L._SL160_.jpg",
  :first_words=>"\"For a long time, I would go to bed early. [Fr., Longtemps, je me suis couche de bonne heure.]\""},
 {:title=>"Wuthering Heights",
  :author=>"Emily Brontë",
  :image=> "http://ecx.images-amazon.com/images/I/41PziPXlp-L._SL160_.jpg",
  :first_words=>nil},
 {:title=>"The Chronicles of Narnia",
  :author=>"C. S. Lewis",
  :image=> "http://ecx.images-amazon.com/images/I/51telt3xSoL._SL160_.jpg",
  :first_words=>
   "\"There is a story about something that happened long ago when your grandfather was a child. (From The Magician's Nephew, first in chronological order)Once there were four children whose names were...\""},
 {:title=>"The Color Purple",
  :author=>"Alice Walker",
  :image=> "http://ecx.images-amazon.com/images/I/51vSNfELsRL._SL160_.jpg",
  :first_words=>"\"You better not never tell nobody but God. It'd kill your mammy.\""},
 {:title=>"Midnight's Children",
  :author=>"Salman Rushdie",
  :image=> "http://ecx.images-amazon.com/images/I/51yqNUCZu6L._SL160_.jpg",
  :first_words=>"\"I was born in the city of Bombay . . . once upon a time.\""},
 {:title=>"A Portrait of the Artist as a Young Man",
  :author=>"James Joyce",
  :image=> "http://ecx.images-amazon.com/images/I/51XGUrSRx1L._SL160_.jpg",
  :first_words=>
   "\"Once upon a time and a very good time it was there was a moocow coming down along the road and this moocow that was down along the road met a nicens little boy named baby tuckoo....\""},
  {:title=>"Winnie-the-Pooh",
  :author=>"A. A. Milne",
  :image=> "http://ecx.images-amazon.com/images/I/51uHWJgBHqL._SL160_.jpg",
  :first_words=>
   "\"Here is Edward Bear, coming downstairs now, bump, bump, bump, on the back of his head, behind Christopher Robin.\""},
 {:title=>"Heart of Darkness",
  :author=>"Joseph Conrad",
  :image=> "http://ecx.images-amazon.com/images/I/51iArzZOQXL._SL160_.jpg",
  :first_words=>
   "\"The Nellie, a cruising yawl, swung to her anchor without a flutter of the sails, and was at rest. The flood had made, the wind was nearly calm, and being bound down the river, the only thing for it...\""},
 {:title=>"Mrs Dalloway",
  :author=>"Virginia Woolf",
  :image=> "http://ecx.images-amazon.com/images/I/41OmrKHsivL._SL160_.jpg",
  :first_words=>
   "\"Mrs. Dalloway said she would buy the flowers herself. For Lucy had her work cut out for her. The doors would be taken off their hinges; Rumpelmayer’s men were coming. And then, thought Clarissa...\""},
 {:title=>"Slaughterhouse-Five",
  :author=>"Kurt Vonnegut",
  :image=> "http://ecx.images-amazon.com/images/I/41eCbb308tL._SL160_.jpg",
  :first_words=>"\"All this happened, more or less.\""},
 {:title=>"War and Peace",
  :author=>"Leo Tolstoy",
  :image=> "http://ecx.images-amazon.com/images/I/41w-juERc9L._SL160_.jpg",
  :first_words=>
   "\"Well, Prince, Genoa and Lucca are now no more than private estates of the Bonaparte family.\"Well, Prince, so Genoa and Lucca are now just family estates of the Buonapartes. (Maude/Maude)"},
 {:title=>"Of Mice and Men",
  :author=>"John Steinbeck",
  :image=> "http://ecx.images-amazon.com/images/I/51I%2Ben%2B9kxL._SL160_.jpg",
  :first_words=>
   "\"A few miles south of Soledad, the Salinas River drops in close to the hillside bank and runs deep and green.\""},
 {:title=>"Moby-Dick",
  :author=>"Herman Melville",
  :image=> "http://ecx.images-amazon.com/images/I/51YQ8fgFoLL._SL160_.jpg",
  :first_words=>
   "\"Call me Ishmael. Some years ago—never mind how long precisely—having little or no money in my purse, and nothing particular to interest me on shore, I thought I would sail about a little and see...\""},
 {:title=>"Little Women",
  :author=>"Louisa May Alcott",
  :image=> "http://ecx.images-amazon.com/images/I/41O9A%2Bdx2tL._SL160_.jpg",
  :first_words=>"\"“Christmas won't be Christmas without any presents,” grumbled Jo, lying on the rug.\""},
 {:title=>"Native Son",
  :author=>"Richard Wright",
  :image=> "http://ecx.images-amazon.com/images/I/51ow3TP0CqL._SL160_.jpg",
  :first_words=>"\"Brrrrrrriiiiiiiiiiiiiiiiiinng! An alarm clock clanged in the dark and silent room.\""},
 {:title=>"The Hitchhiker's Guide to the Galaxy",
  :author=>"Douglas Adams",
  :image=> "http://ecx.images-amazon.com/images/I/51d5tk7z3qL._SL160_.jpg",
  :first_words=>
   "\"Far out in the uncharted backwaters of the unfashionable end of the Western Spiral arm of the Galaxy lies a small unregarded yellow sun. Orbiting this at a distance of roughly ninety-eight million...\""},
   {:title=>"Great Expectations",
   :author=>"Charles Dickens",
   :image=> "http://ecx.images-amazon.com/images/I/61S-Z-69B6L._SL160_.jpg",
   :first_words=>
    "\"My father's family name being Pirrip, and my christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip. So, I called myself Pip, and came to be...\""},
  {:title=>"The Sun Also Rises",
   :author=>"Ernest Hemingway",
   :image=> "http://ecx.images-amazon.com/images/I/413SnoVxOxL._SL160_.jpg",
   :first_words=>"\"Robert Cohn was once middleweight boxing champion of Princeton.\""},
  {:title=>"Rebecca",
   :author=>"Daphne du Maurier",
   :image=> "http://ecx.images-amazon.com/images/I/51Z4jHj0LCL._SL160_.jpg",
   :first_words=>"\"Last night I dreamt I went to Manderley again.\""},
  {:title=>"The Stranger",
   :author=>"Albert Camus",
   :image=> "http://ecx.images-amazon.com/images/I/51wRB2cJSJL._SL160_.jpg",
   :first_words=>
    "\"Mother died today. (Stuart Gilbert translation)Maman died today. (Matthew Ward translation)Aujourd'hui, maman est morte. Ou peut-être hier, je ne sais pas.\""},
  {:title=>"Alice's Adventures in Wonderland and Through the Looking Glass",
   :author=>"Lewis Carroll",
   :image=> "http://ecx.images-amazon.com/images/I/51vg8TU474L._SL160_.jpg",
   :first_words=>
    "\"Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do; once or twice she had peeped into the book her sister was reading, but it had no pictures or...\""},
  {:title=>"For Whom the Bell Tolls",
   :author=>"Ernest Hemingway",
   :image=> "http://ecx.images-amazon.com/images/I/51%2BBd3s1bjL._SL160_.jpg",
   :first_words=>
    "\"He lay flat on the brown, pine-needled floor of the forest, his chin on his folded arms, and high overhead the wind blew in the tops of the pine trees.\""},
  {:title=>"The Hobbit",
   :author=>"J. R. R. Tolkien",
   :image=> "http://ecx.images-amazon.com/images/I/41tzgUUcRJL._SL160_.jpg",
   :first_words=>
    "\"In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to...\""},
  {:title=>"Madame Bovary",
   :author=>"Gustave Flaubert",
   :image=> "http://ecx.images-amazon.com/images/I/51QXxOgrAFL._SL160_.jpg",
   :first_words=>
    "\"Nous étions à l'Etude, quand le Proviseur entra suivi d'un \"nouveau\" habillé en bourgeois et d'un garçon de classe qui portait un grand pupitre.We were in study hall when the headmaster walked in,...\""},
  {:title=>"The Wind in the Willows",
   :author=>"Kenneth Grahame",
   :image=> "http://ecx.images-amazon.com/images/I/51UAK4ebtvL._SL160_.jpg",
   :first_words=>"\"The Mole had been working very hard all the morning, spring- cleaning his little home. \""},
  {:title=>"The Handmaid’s Tale",
   :author=>"Margaret Atwood",
   :image=> "http://ecx.images-amazon.com/images/I/511MKBHv95L._SL160_.jpg",
   :first_words=>"\"We slept in what had once been the gymnasium.\""}
])