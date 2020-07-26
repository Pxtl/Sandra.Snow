---
published: published 
layout: post 
category: Software 
title: Saving Uranus
---

So I'm finally getting myself a new computer.  Had it all figured out - new
off-lease desktops were coming available for my kids, and I was going to buy
myself a brand-new gaming machine.  No hard feelings because everybody's getting
a new machine at once.

Just had to wait until August.

Which is why it's awesome that my kids' computer (named Uranus) died.  And died in an
infuriating way - it was murdered by its own software.

See, suddenly my son was upset that he couldn't open the shutdown menu.  Or
search the start menu.  On closer examination, the problem was pervasive -
couldn't open sub-menus in start, couldn't use the address bar in IE, couldn't
open uninstall dialogs in the add/remove program screen.  Any new-windows-UI
screen that tried to create a floating widget failed.

So I went through the expected stack of approaches that every forum will rattle off:

- sfc /scannow
- dism (both variants)
- various built-in troubleshooters
- installing all updates
- uninstalling recent updates
- a big crazy powershell scripts that reinstalls as much of the Universal
    Windows Platform (UWP) apps.
- switching to other user profiles - each of my children have their own user
    account and they all have this bug 
- turning off all startup programs in task manager restart with msconfig with
    all non-microsoft services turned off 
- safe mode... which worked!  But you can't live in safe mode.
- reinstall the OS (without removing software)

Aside, "answers.microsoft.com" should be renamed "questions" because there are a
lot of people asking things there and not a lot of answers besides "sfc
/scannow".

Ultimately, this came down to "okay, let's reinstall windows".  Which sucked
because it meant sitting down with each of my kids and backing up their stuff.