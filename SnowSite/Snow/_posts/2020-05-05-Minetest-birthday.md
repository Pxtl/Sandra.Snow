---
published: published
layout: post
category: Blog
title: Minetest Birthday
---

Okay, this is part one of a multi-part... well, I guess we can't use the term
"postmortem" that's popular in software development, since it's kind of morbid
for a birthday.  We'll call it an "after-action report".

Basically, we had to handle the challenge of "how do you run a 10th birthday
party with kids under social distancing"?  My answer was cupcakes, Zoom, a
Raspberry Pi 4, and the open-source clone of Minecraft called
[Minetest](https://www.minetest.net).

<!--excerpt-->

# Preamble

So, my daughter is really into Minecraft, in the typical sense that saying
"really into" understates the situation.  I looked into running the party on
name-brand Minecraft, but for a variety of reasons (not all of them good) I
decided to find an alternative.

So, I looked into an open-source reimplementation of Minecraft called Minetest
that I'd been studiously ignoring, created by hobbyists.  The good news was that
it looked like it would meet my needs.  The bad news was that the installation
process was a lot to ask of parents.  So, a 2-part party was planned:

1. First, a Zoom meeting to say happy-birthday and blow out the candles.

2. For those parents who had gotten through the install-and-config process, a
   Minetest sandbox for the kids to play in.

# The Zoom Party

So how do you sing Happy Birthday and blow out candles and eat cake at a
birthday party spread across about a dozen households?  Simple, with Zoom, and
[Cupcakes of Westdale Village](http://www.westdalecupcakes.com/).  This created
a fun wrinkle that all the children got to order their own personal flavour of
cupcake (and a 2nd-choice in case there was a problem).  So, the day before the
party, we gloved up and put on our masks and delivered cupcakes and goodie bags
to all of our attendees.

## Cupcakes 

![Cupcake](/images/2020-05-05-Minetest-birthday/cupcake.jpg)

Of course, we had to go back to the shop to  replace a few of the cupcakes
because my son did not understand that (a) the boxes are not sealed shut, and
(b) they have to stay right-side-up.

Every goody-bag included a candle as well, so every child got to blow out their
own cake as well.

## Zoom

The zoom software actually impresses me, mostly because I've been working with a
lot of the alternatives and they're kind of awful.  A gallery full of screaming
kids, and not using proper headsets, and it works pretty well.  Doing the same
with Mumble creates a nightmarish feedback loop that will feel like being
stabbed in the ear.  Sometimes the audio seems to kick in late, and there's a
lot of latency, and it seems to have a perverse and inexplicable logic for
picking volume for the kids, but it works.

Zoom seems to be consistently dropping the 40 minute limit for free accounts
over the weekends, which was a big help.  Honestly the biggest thing that
impresses me with zoom, at least on desktop, is that they eschew the normal
setup of accounts and logins and all that process - you download an exe for the
meeting you've been invited to and you're rolling.  No setting up a username and
password, no entering in a meeting ID.  It was the one bit of tech we didn't
have to worry about.

![Zoom Cupcakes](/images/2020-05-05-Minetest-birthday/zoom_cupcakes.jpg)

The kids were ecstatic to see each other.  It was fun for them to catch up,
although it's hard for them to manage a conversation in such a massive group.
They sang happy birthday, although the latency in Zoom makes it mathematically
impossible for anybody to keep in time so it just sounds like shouting.  A great
time was had by all.

And then we started up the game.

# Planning The Minetest Party

## The Pi4

It's my wife's fault, really.  She bought me a Raspberry Pi 3b a year or two ago
and I've gotten the Single-Board Computer bug.  A computer that can do all sorts
of things costs less than almost any individual game I bought as a kid.  I've
since converted my old Pi 3b into a Nintendo emulator for my father-in-law, and
upgraded to a trio of Pi 4 devices for various purposes.  

One of these Pi 4s lives under my chest of drawers in my bedroom alongside the
wifi access-point and the Phillips Hue box.

![The Pi 4](/images/2020-05-05-Minetest-birthday/pi4.jpg)

I imagine a really wierd version of Toy Story under there.

For the curious:

- 2GB Raspberry Pi4 
- 32GB microSD card (some name-brand one - never buy no-name SDs on Amazon,
  they'll only break your heart)
- Official USB power-supply
- Miuzei air-cooled case kit (includes heatsinks and fan)

The case was fun, despite being a no-name Chinese one.  We made two of these.
My son has always fantasized about building a gaming PC so this got him screwing
parts together and taping on the heatsinks onto the Pi4 devices.  The Miuzei
only cost a two bucks more than the "official" Pi4 case and it looks better and
has a nice silent fan to cool it for overclocking (I don't overclock this one
but the other one I made for my brother is overclocked).

My son named it Kosmos.  It runs our Minetest world.

## Setting Up Minetest

[Minetest](https://www.minetest.net) is a free, open-source copy of Minecraft
made by hobbyists.  For fans of Minecraft: yeah, it's a pale shadow of the
original. The problem is that Minecraft has a proliferation of versions.  Tablet
versions, two different PC versions, and two different incompatible server
versions for running worlds. All sold separately.  I didn't want to have to
figure out which version which kids had and figure out what to do there... And
worse, the newer "bedrock" version is only really practically hosted in The
Cloud.  It doesn't let me run the world on my own hardware, and I insist on
ruling my childrens' game-worlds like an iron-fisted despot.

So, I gave the hobby-made imitation a try... and found that after installing a
"subgame" called [MineClone 2](https://forum.minetest.net/viewtopic.php?t=16407)
that makes it a more complete imitation of MineCraft (the stock Minetest subgame
doesn't include animals and monsters), it was a good fit.

For hardcore minecraft fans: Mineclone 2 is a pale imitation.  The graphics are
a bit uglier, it's a bit slower, the monsters are dumber, animals keep walking
into the river and floating away, there are gaps in the gameplay, and there's no
villages.  But for people who just want to build houses and have a stable of
rabbits, it's more than good enough.  Especially in just "Creative mode" which
turns the game into more interactive lego than an actual game with objectives
and challenges.

![Minetest Group Screenshot](/images/2020-05-05-Minetest-birthday/screenshot_20200503_142525.jpg)

The biggest challenge with minetest is the installation process: it doesn't have
one.  The game is packed up as a raw zip file and you unzip it on your machine.
You have to suss out that the executable lives in the "bin" folder (which makes
perfect sense to nobody but us programmers), and when you run the exe you'll
have to agree to numerous Windows warnings about this unsigned, unverified
program that has been unceremoniously dumped into a folder on your computer and
is asking for network privileges.

On the other hand, Mineclone 2 also lacks an installation process, but in a good
way: you just connect to my Minetest world and you'll automatically download
Mineclone 2.  Along with the 90 or so skins I've installed into it for the kids
to choose from.  And any other mods the server is running.

![Birthday Banner](/images/2020-05-05-Minetest-birthday/birthday-banner.jpg)

Mineclone 2/Minetest also has an in-game skin-picker and lets you choose your
name.  This seems like a small thing but I've seen too many games of Minecraft
where somebody is borrowing their brother's account or something and nobody
knows who they are because it shows the wrong name.

## Setting Up Mumble

Another server running on my little Pi4 is [Mumble](https://www.mumble.info/).  Mumble is a wonderful
open-source voicechat system designed for gaming.  It's fast, low-resource,
low-latency and has a wonderful configuration wizard where it talks you through
getting your computer's microphone configured just right to make sure all your
friends will have the best experience talking to you.

Everyone **hated** it.

The config wizard is difficult, it has a bizarre cryptographic-key-based
authentication system, and we were unable to get it working on our friends' mac.
Most unforgivably it has no echo-cancelling to speak of so when our friends
joined in a dry-run using their straight laptop speaker and microphone instead
of a proper headset, the feedback-loop was ear-splitting.

I'll still insist it's the right tool for enthusiasts - the sound is crystal
clear and there's none of the delay that causes awkward interrupting and
cross-talk in Zoom.  But not for a birthday party, unless it's a birthday party
full of programmers and gamers where everybody has a good headset.

When we realized that Mumble was a usability disaster, we changed the plan to
just use Zoom for the minetest game too.  

I wrote a four-page document for parents about the software we were using for
this party, URLs, passwords, etc.  Three of them were on Mumble.  I should've
realized it when I had to add the section about "configuring push-to-talk" but
I'm stubborn. 

We kept the Mumble server as "plan B" if Zoom didn't work well.

# The Minetest Party

Not everybody could join.  I assume some parents saw the PDF I sent and noped
the heck out of doing tech-support for a 10 year old on a Sunday afternoon and I
don't blame them one bit.  But a good crowd of kids joined the game.

![Daughter Playing](/images/2020-05-05-Minetest-birthday/g-gaming.jpg)

It was a hit.  I had to furiously type teleport commands as fast as I could to
get the kids all into the same area to introduce them and give them the lay of
the land:

1. Explain how to play and the differences between Minetest and Minecraft.
   Everybody had it down inside of 10 minutes.

2. The world is backed up and we're reverting it after the party so anything you
   make is going bye-bye.  This was mostly to prevent any tantrums if my
   daughters meticulously-constructed villages got obliterated.

3. How to pick skins.  This was, of course, their first question.

Also, apparently you can't teleport somebody out of a minecart in minetest.
This was a problem when people would not know how to dismount (look down and
rclick) and my main tool for rescuing trapped and lost kids was teleporting
them.  I had to enlist my son to be assistant-teleporter.

At the same time, I had to juggle this and try to debug issues with people who
couldn't make it through the installation and game-joining process.  That was
hard - trying to isolate and work with one frustrated parent in a noisy Zoom
room is excruciating.

![Full Screenshot](/images/2020-05-05-Minetest-birthday/double-screenshot.jpg)

*note: faces of my daughters' friends redacted.  Also, this is my son's
screenshot, I was answering those support requests in chat on whisper from
another machine.  And yes, my desktop is messy.*

Zoom got the job done for audio, barely.  My kids are *loud*.  I would see my
daughter grabbing the mic of her headset and practically jamming it into her
mouth to holler to her friends to come follow her and explore the underground
minecart tracks.  I kept having to explain to them that they don't have to
shout, their friends' ears are *two inches from their mouths*.

I needed Tylenol fresh air after 20 minutes of that.  The kids went on for 2
hours, and I have no idea how they did it.  One challenge I didn't expect was
that, because this was a completely open sandbox - no challenge or objective -
the kids tended to follow just schoolyard rules of making up activities.  This
creates the usual problem with all the kids clamoring for each others'
attention, compounded by the fact that they're doing that all directly in my
ears.  I figure a more traditional online gaming format like a deathmatch
would've solved that non-objective problem but created a whole slew of new ones.

In the final act they had fun destroying my daughters' meticulously constructed
village with a rain of killer bunnies, lava, and explosive minecarts (see the
previous note about taking a backup of my daughters' world before we started).
I had to wipe the objects from the world multiple times because mineclone's
animals are *not* coded to support large-scale use and the world would crawl
when they created too many of them.

![Lava and Killer Bunnies](/images/2020-05-05-Minetest-birthday/lava-and-bunnies.jpg)

So yeah, overall?  Definitely a success.  My daughter and her friends are
talking about meeting up regularly in our little mineclone world.  Meanwhile I'm
trying to figure out what game to try next.

# Next Time

Next post, I'll get into the weeds of the setup process and gotchas for getting
these servers set up on a Pi4.  Recipes!  Linux!  Sudo all the things!