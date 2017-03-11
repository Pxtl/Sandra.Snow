---
published: published
layout: post
category: Programming
title: XmlCommentMarkDownGenerator
---

I've released version 0.2 of [XmlCommentMarkDownGenerator](https://github.com/Pxtl/XmlCommentMarkDownGenerator).  If you're running a C#-based project on GitHub, it could be useful to you - it takes your Xml comments and converts them into GitHub-flavoured markdown.  This gives you a nice document page right in your repo that you can link to.  I've set it up as a NuGet package, so in your C# project all you have to do is add the NuGet package to your project and it will add a post-build step to your project to automatically run the tool and generate the markdown file.  I was surprised that NuGet makes that a thing - apparently it's called custom .targets.  See [https://github.com/Pxtl/XmlCommentMarkDownGenerator/blob/master/PxtlCa.XmlCommentMarkDownGenerator.targets](https://github.com/Pxtl/XmlCommentMarkDownGenerator/blob/master/PxtlCa.XmlCommentMarkDownGenerator.targets) to see how that kind of "custom post-build-step as a nuget package" thing is implemented.

It was forked from [https://gist.github.com/lontivero/593fc51f1208555112e0](https://gist.github.com/lontivero/593fc51f1208555112e0), but I'd like to think I've polished it up a fair bit.  This was really just a side-project while I worked on BigVariant and Nustache, but it's the one with the most stars and downloads so I thought I should give it a little TLC.  Pull requests are always welcome. 