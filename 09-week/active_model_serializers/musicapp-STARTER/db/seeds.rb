Band.destroy_all
Genre.destroy_all
Album.destroy_all
Song.destroy_all

#create two new bands
kanye = Band.create(name: "Kanye West")
jay_z = Band.create(name: "Jay-Z")

#create a new genre
hip_hop = Genre.create(name: "hip hop")

#create two new albums, one belonging to each of the two bands above
graduation = Album.create(name: "Graduation", year_released: 2007, running_time: "51 minutes", band: kanye, genre: hip_hop)
blue_print = Album.create(name: "The Blueprint", year_released: 2001, running_time: "63 minutes", band: jay_z, genre: hip_hop)

#create new songs belonging to the two new albums and bands above
Song.create(name: "Good Morning", running_time: "3:15", track: 1, album: graduation, band: kanye)
Song.create(name: "Champion", running_time: "2:48", track: 2, album: graduation, band: kanye)
Song.create(name: "Stronger", running_time: "5:12", track: 3, album: graduation, band: kanye)
Song.create(name: "I Wonder", running_time: "4:03", track: 4, album: graduation, band: kanye)
Song.create(name: "Good Life", running_time: "3:27", track: 5, album: graduation, band: kanye)
Song.create(name: "Can't Tell Me Nothing", running_time: "4:32", track: 1, album: graduation, band: kanye)

Song.create(name: "The Ruler's Back", running_time: "3:49", track: 1, album: blue_print, band: jay_z)
Song.create(name: "Takeover", running_time: "5:13", track: 2, album: blue_print, band: jay_z)
Song.create(name: "Izzo (H.O.V.A.)", running_time: "4:00", track: 3, album: blue_print, band: jay_z)
Song.create(name: "Girls, Girls, Girls", running_time: "4:35", track: 4, album: blue_print, band: jay_z)
