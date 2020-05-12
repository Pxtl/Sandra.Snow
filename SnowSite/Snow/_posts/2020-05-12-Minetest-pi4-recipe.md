---
published: published 
layout: post 
category: Software 
title: Minetest Pi4 Recipe
---

Continuing from my previous article on my daughter's Minetest birthday party,
here's how I built my Raspberry Pi 4 minetest server that powered the party.  To
be clear: this is only my second time this century setting up a linux-based
server from scratch, so I'm pretty novice at this.  I'm handy with a terminal
console but only on Windows.  The intended reader of this article is... well,
somebody like me.  Somebody new to Linux but very comfy with Windows.

<!--excerpt-->

# Hardware

## Pi Hardware

- [2GB Raspberry Pi4 with official USB
  power-supply](https://www.buyapi.ca/product/raspberry-pi-4-model-b-2gb/)
   - 32GB microSD card (some name-brand one; never buy no-name SDs on Amazon,
     they'll only break your heart)
   - good brands: Kingston, Samsung, Patriot, etc.
- [Miuzei air-cooled case kit (includes heat-sinks and
  fan)](https://www.amazon.ca/Miuzei-Raspberry-Cooling-Aluminum-Model/dp/B07WJ8KHS6)
  
   - like all off-brand stuff on Amazon, individual listings are ephemeral, so
     you may have to search for a different listing. I paid $15CAD.
- Ethernet cable

The Miuzei case comes with good easy-to-follow instructions for assembly.  There
are two possible configurations of the fan, a low-power mode and a high-power
mode.  We used the low-power mode, even on an overclocked emulation box.  It's
more than enough for our minetest server.

## Supporting Hardware

This stuff you'll need for the setup process.

- A computer capable of running PuTTY and Minetest
    - I've also done some of this this from Linux and Android (don't recommend
      that), but I'm going to be using Windows tools.
- Spare keyboard
- Spare mouse
- Spare monitor/TV with HDMI hookup
    - Note the Pi4 uses micro-HDMI, which is *not* common. I bought [these
      adapters](https://www.amazon.ca/Cable-Matters-Plated-Female-Adapter/dp/B00JDRHQ58)
      for my Pi devices.
- Wifi or ethernet accessible to the location with all the above equipment.
- A router you're comfy setting port-forwarding and static-IPs on.  You might
  need to Google how to do that on your router.

# OS Setup 

You can download-and-burn the image onto a MicroSD using [Raspberry Pi
Imager](https://www.raspberrypi.org/downloads/), but I prefer to download the
image manually and burn it to the MicroSD using [Balena
Etcher](https://www.balena.io/etcher/).

Once you have the image burned and inserted into the Pi, you'll need to get it
set up for remoting - but the first time it's going to need a mouse, keyboard,
and HDMI-connected monitor until we can setup remoting.  I plugged the setup
into a TV and mouse/keyboard. For operating system: The system is running
Raspbian Buster (Raspbian is the Linux variant, Buster is the version number).

Raspbian will walk through a pretty easy wizard after startup to connect to wifi
and set a password.

## Remoting

The first step to setting up remoting is getting a static IP bound to your
raspi.  

Open a terminal and run the command.

```sh
ifconfig
```

will list your IP addresses and MAC addresses.  The you want `eth0` for wired,
and `wlan0` for wireless.  The ipv4 address we're focusing on will be labeled
`inet`, and the mac address will be labeled `ether` - the ipv4 address will be
generally be of the form `192.168.something.something`.  The next steps are
router-specific: write down the `ether` MAC info from `ifconfig` and use it to
set up static IP for your router - still local, we're still in
`192.168.something.something`, but we need a static one that won't change every
time we reboot.  I generally set my router to start dynamic IP addresses at
`192.168.1.100` and use numbers `192.168.1.10` to `192.168.1.99` for any
computer I want to give a static address. This will make port forwarding easier
in the future. The only wrinkle is that the wifi and ethernet interfaces will
each have their own MAC address and IP, and you'll have to decide which you want
to static bind.

The important steps afterwards are to enable SSH and the VNC Server.  

Again, in the terminal type

```sh
sudo raspi-config
```

This will launch a simple UI for editing settings.  Use in "interface options"
enable SSH and VNC.  VNC will let you remote in for a GUI and SSH will let you
remote a terminal/text-console and file-transfers in.

## Remoting Clients

You need to install some remote admin software on your PC if you don't have it
already:

- RealVNC (gui remoting)
- PuTTY (terminal remoting)
- WinSCP (file transfer)

All are available from [ninite.com](https://ninite.com/).  Personally I prefer
mRemoteNG to PuTTY, but it's got a less memorable name and a more elaborate UI.

Confirm that you can connect PuTTY and RealVNC to your new Pi server.  You'll
need to use the IP address you set up on your router and the username (pi,
generally) and password you set up earlier in the Raspbian setup wizard.

## Moving into headless mode

At this point, your pi is now ready to be remote-only.  Unhook it from the
mouse, keyboard, and monitor and put it in its final resting place, and wire it
up with just ethernet and power.  You may have to tweak your Router settings to
switch over from Wifi to wired for static IP if you're going from a wireless
connection to wired (I actually forgot this step, so all my traffic to my pi4
was going over wifi even though it was plugged in).

# Using the Terminal to hook into the Debian Buster Backports software repository

Before we can install the minetest server, we have a problem: Raspbian and
Debian Buster tend to have somewhat stale software.  We need a fresher version
of Minetest, so we're going to link up to the buster-backports system for that.

## Welcome to the terminal

We're going to be doing all this in the terminal.  On your desktop, open up
PuTTY, connect to your Pi4 device using the static-IP, the pi username, and the
password.  The linux terminal isn't as scary as you think -- after all, by
default it's so locked down you can't actually do any damage without `sudo`,
which is basically Linux' way of saying "this line does something scary".  

We'll be using `sudo` a lot.

[The basic list of commands we'll be working with are listed
here](https://en.wikibooks.org/wiki/Guide_to_Unix/Commands/File_System_Utilities).
In particular, `cd`, `ls`, `cp`, `mv`, `rm`, `chmod` and `chown`.  Be fearless
and stupid.  We're mostly just installing software and tweaking some files.
Worst case scenario, don't be afraid to wipe the thing and start over.

## Hooking into Buster-Backports

As mentioned earlier, raspbian Buster is *almost* Debian.  Debian being a large,
popular Linux software distro, has an extensive library of programs available
for it.  And Raspbian can run Debian software... but by default, it's not hooked
up to access Debian's latest software apt software repository.  For this
Raspbian Buster device, the repository we need to connect to is called "Buster
Backports", which is to say back-ports of cutting-edge software to the "stable"
Buster version of Raspbian/Debian.

So, first, we need to let Raspbian know it's safe to talk to the Backports repo.

In our terminal, we run the following:

```sh
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E0B11894F66AEC98
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
```

I'm going to be honest, I don't know what it actually does in detail, and
generally copying pasting sudo commands into your machine is a bad idea,
especially stuff involving security keys.  But in this case, its's obviously
wiring into a something provided by Ubuntu, who being one of the big daddies of
Linux right now I tend to trust.

If you're new to linux and PuTTY: `right-click` or `shift`+`insert` means paste.
That'll be handy for copying commands from here to paste in there.

Next, we add the `buster-backports` repository to the registry of apt
installation sources.  This mammoth command adds the configuration to connect to
"buster-backports" into our sources list for installing software.

```sh
echo 'deb http://httpredir.debian.org/debian buster-backports main contrib non-free' | sudo tee -a /etc/apt/sources.list.d/debian-backports.list
```

This script I can explain.  Skip this if you're experienced in the ways of
Linux.  `echo 'deb http://yadda` just means "output the quoted text" the `|`
means "take the output of the command on the left of the `|` and shove it into
the command on the right.  `tee -a somefilepath` means "open somefilepath and
append the stuff shoved into this command at the end of that file and also echo
it to the screen so we can see it".  So we're taking the quoted line and
stuffing it at the end of the file `debian-backports.list`, which will
effectively add the buster backports repository to our sources list so we can
now install software from there.

Now, we have to let the "apt" installation system know that there's the new
source available to it, so we'll do

```sh
sudo apt-get update
```

and finally we're ready to start installing software.

# Installing and Configuring minetest-server

I worked heavily from [this guide on the minetest
wiki](https://wiki.minetest.net/Setting_up_a_server/Debian) but found it didn't
have much context for a novice like me so I'm going to slow it down and give you
a deep dive on the linuxisms involved.

## Minetest-server, systemd, and an intro to file permissions

We're not going to do raw minetest, but rather "minetest-server" which installs
minetest *and* sets it up into the service system in Raspbian so it runs
securely with its own user (the user `Debian-minetest` of group `games`).  The
only warning is that this server-daemon approach means that a lot of the support
documents about minetest are going to be confusing for you because *we never
actually run minetest*, which is something the docs talk about a lot.  Instead,
we tell `systemd`, Raspbian's service manager, to do that for us.  It does on
startup and handles the details. Helpful, but opaque.

### Quick intro to file-permissions and Linux users

One wrinkle about this is that our `pi` user isn't actually involved in running
the software.  Minetest-server actually uses its own linux user - so there's a
separate account responsible for running the server, and any time it needs to
look at a file we have to grant permission or ownership to that user to muck
with that file.

So we're going to be needing to get acquainted with some linux commands.  We
won't be using them much until we really get into the weeds with our minetest
server, but for now you should meet them.

`chown` is "change file owner/group".  We need to use this to assign ownership
of a file or folder to our service-user, who is named `Debian-minetest` of group
`games`.  So to assign a file to `Debian-minetest`, we do

```sh
sudo chown Debian-minetest:games <filename>
```

Optionally with a `--recursive` flag if you want to do it to every file in a
directory-tree.

Similarly, to grant permissions for that user, we're going to use `chmod`, which
is "change mode" but is really about modifying file permissions.

You'll notice we usually call commands with `-` parameters, but in the case of
`chmod`, we use `+` parameters - this is something I have not gotten used to
since it is *not* a thing in windows/powershell scripting.

```sh
sudo chmod +rwx <filename>
```

This grants the owner **r**ead, **w**rite, and e**x**ecute permissions to a
file.

Again, you can use a directory (or a wildcard like *) instead of a filename, and
you can have it do the action to everything in the directory tree by using
`--recursive`

Finally, `ls` is how to list the contents of a directory, but we want `ls -l` to
list them and show the owner and permissions so we can be sure we did the above
right.

I know I'm getting pretty deep into the weeds, but file permissions were 99% of
my struggle since they're barely a thing on Windows, so I figured it was worth
breaking it down here before we go any deeper - hopefully if anything goes
sideways, you now have enough to unmangle a file permission or two.

## Install and config

So, install minetest-server from the buster-backports source we just finished
hooking into.

```
sudo apt-get -t buster-backports install minetest-server
```

Then create and setup our config file.  That's where a lot of the meat will be
happening - we've got the game installed, but our server is private and
unsecured and all that.  We want something we can *control*.  My daughter and
her friends are playing in there.

```sh
#unzip the starting config - I'm pretty sure this step is unnecessary and might ruin 
#privileges on minetest.conf - only do this if /etc/minetest/minetest.conf wasn't created
#automatically
sudo zcat /usr/share/doc/minetest/minetest.conf.example.gz > /etc/minetest/minetest.conf

#open the config up in the editor to get to work
sudo nano /etc/minetest/minetest.conf
```

The file `/etc/minetest/minetest.conf` contains a pretty-well-annotated config
of everything about our minetest server.  The only big gotcha is that you *must*
set a `bind_address` to make your server accessible to anybody.  The default is
0.0.0.0, which is supposed to mean "accept all incoming connections" but somehow
either minetest or systemd get cranky and instead accept *no* connections.  So
take that static IP you set on your server way back at the beginning of this
recipe, and put it in `bind_address`.

Second, you want a password, at least until you're ready to unleash this thing
on the public world.  Set `default_password`.  

You can set a nice name, grant players some default privileges, and publicize it
in the server browser so players can search you out in the listing.

To start?  Probably focus on `bind_address`, a `server_name`, the name of your
admin user (`name`) and a `default_password`.  Maybe decide if you want your
first world to be creative mode or not

If you've never used *Nano* before, it's actually pretty easy in a linuxy way -
normal cursor controls (don't try to mouse-scroll though), but doesn't use
windows-standard hotkeys.  Everywhere in linux, ctrl-C means "break whatever's
going on", so copy-paste is highlight and rclick instead.  Don't try to undo
with ctrl-Z either, that means suspend the current program and switch to console
(`fg %1` to come back, meaning put suspended app **1** back in the
**f**ore**g**round).  `Ctrl` + the keys listed along the bottom are the hotkeys,
like `ctrl`+`w` to search, `ctrl`+`o` to save, `ctrl`+`x` to quit.

Finally, our first chmod command:

```sh
#enable writing of the log file for all users so we can see what’s going on
sudo chmod a+rw /var/log/minetest/minetest.log
```

We need Minetest to be allowed to write to the minetest log file.  The "a" in
that chmod means "all users", we're going to keep this simple.  I know you have
to do this step because I *didn't* do it and it errored out when I tried to
start up the server... I don't know, if the file doesn't exist yet just start
the server and then chmod it afterwards. Or like `echo '' |
/var/log/minetest/minetest.log` to create it blank.  Whatever.

## Start it up

Now that our Minetest server is installed and configured, it's time to cross our
fingers and start it up.

First, meet `systemctl`.  That's systemd's tool for you to manage services that
it runs for you.

```sh
sudo systemctl start minetest-server
```

This means we let it rip.  For future reference, there's also `systemctl stop`
and `systemctl restart` that do what they sound like.

Install the minetest desktop program onto another machine, or even an Android
phone (or hell, vnc into the raspi and install the desktop version of minetest -
it's barely usable but enough to check connections) and try to connect to your
server by the local `192.168.something.something` static address.  This will
confirm you've got the minetest server running.  Don't forget your
`default_password`.

If it doesn't work?  Check `/var/log/minetest/minetest.log`.  You can read the
whole file with the command `cat /var/log/minetest/minetest.log`, or just the
very end of the file with `tail /var/log/minetest/minetest.log`.  You really
want to see the line

`Server for gameid="minetest" listening on 192.168.something.something:30000.`

If you don't see it yet, keep checking with `tail
/var/log/minetest/minetest.log` for about a minute. If there's an error in
there, take it seriously and try to figure it out.

If it does work and you connect?  Celebrate!  And while you're in there, log in
with your admin user (the one you set as `name` in the minetest.conf) and use
the gui to change their password, since you'll be giving that one away to your
friends.

## Getting your server into the public internet.

We're going to do a bit more tweaking of the minetest.conf, so let's stop the
server for a minute with 

```sh
sudo systemctl stop minetest-server
```

... you're getting the hang of this right?  Remember, use ctrl-R to find old
commands in the history so you're not typing that mouthful over and over again.
Also tab-completion.  Als the up and down keys to find previous commands.

This part's a bit awkward because I have a domain name pointing at my house, and
you might not have that.  If you do have one, then set that on `server-address`
in your minetest.conf to point it there.  Otherwise, leave the `server-address`
line commented out with a `#`... I've read it *should* work but I haven't tried
it myself.

While you're in minetest.conf, you can also set `server_announce = true` because
your server is passworded with a secure password so you won't get random
griefers smashing it up.  You set a `default_password`, right?

Anyways, the next step here is setting up port-forwarding on your router.  By
default, the minetest server runs on port 30000.  That's thirty-thousand, not
three-thousand (had to explain it to my daughter a few times).  In your router,
get all incoming UDP traffic coming to 30000 forwarded to that
192.168.something.something static IP.  Now you're on the public internet.

Now, let's start it back up.

```sh
sudo systemctl start minetest-server
```

The system will take a minute to start up - you can tail the log to check on its
progress.  Give it a minute or two and then search of your `server-name` in the
minetest desktop GUI server-browser.  Hopefully it's online and you can connect!

# Yay, it Works!

Except that it's just vanilla minetest game.  It's not Mineclone2. Also, where's
our Mumble server, you want me to type chat into the console like a caveman?
Still, at the end of this article, we've got something useful!  You and your
friends can play vanilla Minetest game on your pi4 server now.

Next time, more stuff.