---
published: published 
layout: post 
category: Software
title: Using the BlueSky API to change your Handle to your Domain Name
---

Personally in the post-Muskening twitter world, I'm pulling for
[Mastodon](https://mastodon.social/@pxtl), but
[Bluesky](https://bsky.app/profile/pxtl.ca) is a somewhat interesting platform
too.  One feature of Bluesky that stands out is that you can set your name to be
based on a domain-name you own.  I own Pxtl.ca, so I thought I'd take a crack at
leveraging that feature.

What follows is a guide on how to do this in Powershell, which is a programming
language you *already have installed* if you use Windows.

<!--excerpt-->

# Preamble

## What you need

I'm going to be doing this in Powershell 5.1, which is what's built into
Windows.  If you're not on Windows or you're a pro-star, you can install
Powershell 7 on any operating system.

Second, you need your own domain.  Those cost money annually, but that's how you
can have your own snazzy site like "Pxtl.ca".  Personally I use Google Domains,
but sadly this is a sunsetting product so going forwards I'm going to need a new
service to run my domain-name subscription.

## Intro to Powershell

First up, we open up our Powershell console.  You can type `⊞ Win` + `R` to
launch the **run** menu to access it, and then type "powershell" to use it.  If
this is your first time running powershell you may need to do some fiddling to
enable it properly.  This will give you a console to run powershell commands.

Now, if you're following along and copying and pasting Powershell code from this
article into your Powershell window, a warning: Copying and pasting code from a
stranger into your console and running it is very dangerous because a computer
does what it's told and this stranger may have told your computer to do
something very bad.  In this situation, I am basically a stranger with candy.

So, don't ever copy/paste code from an article without fully understanding what
it does.  So, I'll be explaining everything I do.

# Logging In to the API

We're going to be sending HTTP commands (like your web browser does, but through
the Powershell console) using a powershell command called `Invoke-RestMethod`.
"Rest" is just a programmer-jargon for "HTTP that uses data structures instead
of websites".

So first, we have to create a session in our console that we can use to do
stuff.  Bluesky/Atproto (their programmer-interface protocol) makes you first
"login" before you can do stuff.

So we run the following:

    $sessionResponse = Invoke-RestMethod -Method POST -Uri https://bsky.social/xrpc/com.atproto.server.createSession `
        -body (@{identifier = 'email@example.com'; password ='PASSWORDGOESHERE'} | ConvertTo-Json) `
        -ContentType 'application/json'

Where "email@example.com" should be replaced with your own email address
associated with your Bluesky account (we don't use your username, just the
email) and PASSWORDGOESHERE is, obviously, your Bluesky password.  If your
password contains a ' char, you'll have to escape it.

So, what this does: We're using Invoke-RestMethod to send a POST action (like
submitting a form on a website) to the url
[https://bsky.social/xrpc/com.atproto.server.createSession](https://bsky.social/xrpc/com.atproto.server.createSession).
We know that the target is trustworthy with your Bluesky password because it's
in the `bsky.social` domain -- that is, we're sending your password to Bluesky,
not to some stranger.

The little backtick at the end of the line is just the simplest way to do
multi-line commands in Powershell.  The backtick-line-continuation is considered
bad form by Powershell people but Powershell is a bad language so imho turnabout
is fair play.

The `-body` parameter is the body of data we're sending to Bluesky.
`@{identifier = 'email@example.com'; password ='PASSWORDGOESHERE'}` is a
Powershell object we're building with the login and password, and then we're
piping it into `| ConvertTo-Json` to turn it into the JSON text format so it can
be sent over the wire to Bluesky.

Finally we let Bluesky know we're sending it as JSON with the parameter
`-ContentType 'application/json'`.

And we store the result of this command into `$sessionResponse`.

## Inspecting the Result

You can inspect `$sessionResponse` by just running `$sessionResponse` in your
Powershell console.  You'll see an object with several members like `did` and
`handle` and `email` and `accessJwt`.  The important bits of data we need going
forwards are `did`, which is your true user-account-ID in Bluesky, and
`accessJwt`, which is the temporary super-long secret code we use going forwards
to do other commands.

Now, the `accessJwt` code is short-lived (a few minutes) before the Bluesky
server decides it doesn't like it anymore, so going forwards you might have to
re-run the `createSession` command above to get a new one if commands start
failing and complaining about security.

# Creating the Domain Record

Okay, so we've proven to Bluesky that we are who we say we are, but how do we
prove to Bluesky that we own the domain?  I mean, I could say I'm google.com or
whatever if they don't check.  But they check.

So, let's say you own `mydomain.com`.  You'll have to go into your domain
registrar's website and create a new TXT record on `mydomain.com` that proves to
Bluesky you own it.  So get the `did` value from `$sessionResponse` by typing
`$sessionResponse.did`.  For example, my `did` value is
`did:plc:otu6mg5xkk47y3ghqpq2w3oo` (this isn't a secret it's fine that you know
that).

Create a new TXT record on `mydomain.com` called `_atproto`, and give it a value
of `did=YOURDIDGOESHERE`.  So for me, I created `_atproto` as a TXT record with
the value `did=did:plc:otu6mg5xkk47y3ghqpq2w3oo`.  Yes it's weirdly
double-barreled with the did=did part.  This is fine.

If you want your name to be some subdomain of your domain, you can even make
`_atproto.somesubdomain`.  I tried this out by making `_atproto.martin` so I
could be "@martin.pxtl.ca".  This is great if you're running an organization and
you've got many users on that domain - you can create one TXT record per-user,
each with their own subdomain, so like if my son got his own Bluesky account (it
would have a different `did`) I could give him `_atproto.gooseguy` so he'd be
"@gooseguy.pxtl.ca".

## Testing the Domain Record

Once the domain record has been created, you can test that it exists with the
Powershell command `Resolve-DnsName`

So, to test it, mash together the TXT record's host name and your domain name,
and call it as follows:

    Resolve-DnsName _atproto.mydomain.ca

So for example for my "@martin.pxtl.ca" name, it would be, 

    Resolve-DnsName _atproto.martin.pxtl.ca

If you get a result talking about the domain and servers and authorities?  It
worked.  If you get ugly red error messages, it didn't.  That might mean you
screwed up, or it just hasn't propagated yet (DNS/domain updates can be slow,
give it a few more minutes).

# Updating your Username

Finally, now that we can log into Bluesky and we've created proof for Bluesky
that we own the domain, we can tell Bluesky to change our name to match our
domain.

    Invoke-RestMethod `
        -Method POST `
        -Uri https://bsky.social/xrpc/com.atproto.identity.updateHandle `
        -Headers @{Authorization = "Bearer $($sessionResponse.accessJwt)"} `
        -Body (@{handle ='mydomain.ca'} | ConvertTo-Json) `
        -ContentType 'application/json'

So again, we're doing an HTTP POST to `bsky.social`, but this time we're calling
`updateHandle` instead of `createSession`.  Since we've already *got* the
session, we need to reference a token (that short-lived secret I mentioned
before) to let them know "yes, I'm still the person you were talking to
earlier".  So we use the parameter `-Headers @{Authorization = "Bearer
$($sessionResponse.accessJwt)"}` which adds the `accessJwt` token to this
request as an `Authorization` header entry.

Again, we're doing a JSON body, but this time the body is just a single entry in
the object `handle`.  That should match the @ handle you're trying to get, the
same one you created a TXT entry for - like, since I did both
`_atproto.martin.pxtl.ca` and `_atproto.pxtl.ca`, I can do either
`handle='pxtl.ca'` or `handle=martin.pxtl.ca`.

This action won't send any result if it works.  It will only give you feedback
if it fails.

So, check your Bluesky account.  There will be errors for a minute or so, but
your user handle should be updated to match your domain.

# TL;DR

In short, in Powershell:

Run

    $sessionResponse = Invoke-RestMethod -Method POST -Uri https://bsky.social/xrpc/com.atproto.server.createSession `
        -body (@{identifier = 'email@example.com'; password ='PASSWORDGOESHERE'} | ConvertTo-Json) `
        -ContentType 'application/json'

with your bluesky email and password.

Get `$sessionResponse.did` and use that when you create a new TXT record on
`yourdomain.com` called `_atproto`, and give it a value of
`did=YOURDIDGOESHERE`.  If you want to use a subdomain of `yourdomain.com`
because you feel like it or you've got friends who want to use the same domain,
you can make `_atproto.mysubmodmain` to get that.

Now, let Bluesky know about it by calling

    Invoke-RestMethod `
        -Method POST `
        -Uri https://bsky.social/xrpc/com.atproto.identity.updateHandle `
        -Headers @{Authorization = "Bearer $($sessionResponse.accessJwt)"} `
        -Body (@{handle ='yourdomain.com'} | ConvertTo-Json) `
        -ContentType 'application/json'

or whatever your domain (or subdomain or whatever) is.

Questions?  Scroll up to the detailed part.  Don't @ me.