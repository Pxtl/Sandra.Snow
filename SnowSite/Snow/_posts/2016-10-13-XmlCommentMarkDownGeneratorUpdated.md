---
published: published
layout: post
category: Programming
title: XmlCommentMarkDownGenerator Updated
---

I'm an idiot.  Always commit everything.  Always.  And only push your build artifacts, not straight from the project.

I omitted the crucial line of the .nuspec that makes the .targets thing work, and so the cool build-generates-your-markdown wasn't actually available for users since version 0.1.5977.1837.  
The latest version 0.2.6130.564 fixes the issue.

A lesson learned, but I wonder how many people I infuriated in the meantime?