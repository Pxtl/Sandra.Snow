---
published: published 
layout: post 
category: Software 
title: Mineclone2 Skins (rpi minetest-server part 4)
---

Continuing on our marathon process of setting up the perfect Mineclone2 server,
this is going to be a brief side-guide - how set up skins in mineclone 2.  I
tried several approaches to this problem - the popular  skin mods in minetest
are meant to manage a connection to an online database of skins, and I just
wanted to pre-load enough skins so the kids would have a library to choose from.

I couldn't get any of the existing skins mods to work fully, so we're going to
just set the files up manually.

<!--excerpt-->

# The MineClone2 Skins Mod

MineClone2 has a built-in skins mod (remember that minetest games are
collections of mods), but it only includes two skins by default. The skins are
located in the `mineclone2` game folder under `mods/PLAYER/mcl_skins`, so on our
Raspbian server it will be located at

   /var/games/minetest-server/.minetest/games/mineclone2/mods/PLAYER/mcl_skins

This is the root folder for the minetest skins mod.  Each skin requires 2 files
and 1 optional file.  Each skin requires

   textures/mcl_skins_character_N.png --the actual skin file
   textures/mcl_skins_player_N.png --the preview of the skin file that you'll see in the picker
   meta/mcl_skins_character_N.txt --the text description of the skin (optional)

where N is the skin's number.  The skins are sequentially numbered wih no gaps -
so I had skins 1 through 94.  If you have a gap in the number mcl_skins will
stop searching.

![example files](images/2020-05-30-Mineclone2-skins/files.jpg)

## The meta txt file

One of the three files is the meta text description of the skin.  It seems to only
ever contain 2 lines:

    name = "Example_skin",
    author = "exampleauthor",

I'm a stickler for credit so I always included the author name, but the
MineClone2 skin picker didn't seem to show it anywhere.

# The source

Mineclone2 skins are downloaded from the [skins
db](http://minetest.fensta.bplaced.net/). Pick the skins you like, download the
skin file and then rclick-save to download the thumbnail.

# The process

So basically, our way to manually set up the skins is

1) On the [skins website](http://minetest.fensta.bplaced.net/), download the
   skin and thumbnail of the skin you like.

2) Rename the thumbnail and skin to match the mineclone2 skin-mod standard,
   being sure to copy out the part of the name that includes the author and
   skin-name.

3) Create a meta txt file with the name and author as described above.

4) Upload the files to your server and put them into the correct folder.

You shouldn't need to `chmod`/`chown` anything because the minetest server users
only need to read the files.

# Next time

Readdyyyy toooooo Mummmbbblle!