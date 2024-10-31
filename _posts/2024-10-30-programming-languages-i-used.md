---
layout: post
title: All the programming languages I have ever used
published: false
---
At the moment of writing this I'm actively looking for a job, and application forms often ask about previous experience with certain programming languages, frameworks, and libraries. Filling these forms and thinking about it later has brought back some memories, both dear and horrifying, which I've decided to write down.

I've included programming languages which match one of the following criteria:

1. I've used it as part of my job, or otherwise made any money from using it.
2. I've used it in a personal project of any size, as long as the purpose was not simply to try the language (but, for example, passing an exam counts). I've completed the said project, by some definition of "done."

Only programming languages are included. I omit languages like CSS, XML, JSON, etc. Arguably, you can write code in some of those under certain conditions, but it's not their primary purpose.

## The list

### ActionScript

In the era of Flash, I've created a rope physics simulation demo in ActionScript, and I vaguely remember creating at least one tiny Flash game.

When I graduated from high school, one of my exams was Informatics (as they were calling the basics of Computer Science), and I have created my presentation in Flash instead of PowerPoint. I don't think anybody noticed or cared, but I felt proud.

ActionScript was not even that bad, despite the fact that it was mostly used to create janky games.

### Assembly (x86)

Used at least once to create an ASCII-art program when I was a kid because it sounded cool. It still sounds cool, actually.

I used to put inline Assembly inside Pascal and Delphi programs with an intent of making critical parts more performant. Whether it helped with performance is unknown, as I was young and inexperienced and didn't do any profiling.

### C

I had a university course on C++, but what was actually taught was C syntax without any C++ features. At least, I don't remember using any C++ features in my course projects, so I wouldn't count this as using C++.

C++ was actually the first language I've ever *tried* to learn at the age of 15 or so, but I quickly gave up because it was too difficult, so I don't count it.

### C#

I also had a university course on C#, and unlike C/C++, I've actually used C# to write useful programs.

The first program I've sold was in C#. The price was in US$20-40 range (equivalent in Russian rubles), but I don't remember exactly. The program was a [15 puzzle](https://en.wikipedia.org/wiki/15_puzzle) implementation with a GUI. It was a course work for another student which they were supposed to do during the whole semester, so I felt proud and a bit ashamed (because I helped them cheat) at the same time.

### Delphi

Delphi was the first programming language which I used extensively to write multiple useful programs. I can barely remember them, but one notable mention was a tool for converting low resolution images into [cross-stitching](https://en.wikipedia.org/wiki/Cross-stitch) schemes for my mother. I was probably around 17-19 years old at that time.

### Java

I have multiple years of professional experience writing Java code for web applications, mostly based on Spring framework in Java versions 6-9. I've also used Hibernate, Apache Wicket, Groovy, and some other stuff I barely remember, so I was pretty familiar with the Java ecosystem.

Can't say I like Java, but it had opened nice remote job opportunities, and also switching from PHP felt really empowering. I barely understood what I was doing at first, but I dug deep and learned rapidly.

### JavaScript

The language I have used the longest, probably first tried it at the age of 15, and use it extensively until this day. Most of the code I've written during the last few years is either JS or compiled into it (see TypeScript below).

Besides JavaScript in web browsers and Node.js, I've played with its cousin language JScript on Windows, for the purposes of automation and creating silly prank scripts.

JavaScript is my "default language" at this point. It's neither good nor bad, it just *is*.

### Kotlin

Haven't used it on any of my full-time jobs, but have several personal FOSS projects written in it, most importantly [jmdict-simplified](https://github.com/scriptin/jmdict-simplified). One of the coolest languages on this list in my opinion.

### Pascal

Mostly the same experience as with Delphi. Many of the programs I've written in Delphi (especially command-line tools) could have been ported to Pascal, but I've also used Turbo Pascal compiler directly during my CS course in university.

### PHP

My first full-time job was writing websites in PHP along with HTML, JS/jQuery, and CSS. I hated it quite a lot, but it paid the bills.

Most of my experience was either writing plain PHP scripts or working with CMSs like Drupal, Joomla, and WordPress, but I've tried a couple of frameworks as well, namely Kohana and Yii.

### Python

Besides several utility scripts, I've used Python for NLP tasks recently, and I find it quite comfortable to work with.

Python was also the language I've used to teach the basics of programming to my friends and family members, with modest success.

### Scala

At the same time I've been doing Java full-time, I had several Scala projects, and the language felt very exciting at first. Then, after experiencing all the complexity hidden in the language itself and its tooling, I became too tired of it to continue using it for anything. But lately, Scala seems to be having a renaissance with its version 2.0, so I might try it again someday.

### Shell scripts (bash, zsh)

I hate every second of it, but it works (except when it doesn't). Small scripts I've written for switching between different version of Java and Tomcat were horrible, but made me productive when it was necessary.

### Solidity

One Ethereum smart contract written and deployed. Yes, it was an NFT. No, I haven't made any money from it. Cool language nonetheless because it really pushes you to think out of the box, into a different box.

### SQL

MySQL, Postgres, SQLite, and a little bit of MS SQL Server. Most web apps need databases, and most databases I've worked with were relational.

I've always treated SQL dialects as "chore" languages, but to be honest, they are one of the most important in my career and deserve more love and attention.

### Swift

I've used it in exactly one project, and liked it quite a lot. Unfortunately, it came with horrible XCode tooling and no dependency manager, but I judge the language by itself.

### TypeScript

I was quite an early adopter, starting as early as v1.x (2014-2015), and I didn't like it at first, but now it's my default language for anything web-related. In small personal projects, I still often use JavaScript, but the rise of Deno, Bun, and generally improving support of TypeScript slowly turns the tide.

This language is the one which brought me the most relief because it makes working on bigger JS projects not just possible, but often actually pleasant.

### XQuery

Not to be confused with jQuery.

This is the most "esoteric" language I've ever used, and I must say I was positively impressed. It's a domain-specific language, and quite a smart one in my opinion.

My [jmdict-simplified](https://github.com/scriptin/jmdict-simplified) project was written in XQuery until v3.2.0. The reason for migrating to Kotlin was the fact that I've run into memory limits since XQuery does not support streaming processing of XML. For smaller XML files, XQuery is viable and even nice as long as you use a right implementation of it (I've settled on [BaseX](http://basex.org/)).

## Honorable mentions

### Haskell

While I haven't really finished any projects in Haskell, I've made multiple attempts at learning it on my own (using **[Learn You a Haskell](https://learnyouahaskell.com/)**). Unlike my C/C++ university course, I haven't even used Haskell for the purpose of passing an exam, so it can't go into the main list.

I wish I had Haskell among my CS courses. I can't call this language practical in some aspects, but it is fascinating to see it applied in compilers, blockchain, or scientific research.

### Lisp (Scheme)

I've accidentally written more than one pair of properly nested parentheses once, which counts as writing Lisp. Just kidding. I vaguely remember working through the **[Structure and Interpretation of Computer Programs (SICP)](https://books.scheme.org/)** in Scheme, and I also did some Emacs Lisp scripting, but Emacs is definitely not my editor, so no dialect of Lisp stuck with me in the end.

### Lua

I tried creating some 2D games in [LÖVE](https://love2d.org/) framework (and some others I can't remember now), but didn't finish any of them. Lua was also a part of some Minecraft mod (I think it was ComputerCraft), and I had a lot of fun programming bots to dig diamonds.

### Processing

It's technically a Java dialect, but since I've mentioned TypeScript and JavaScript separately, Processing deserves a few words as well.

I did quite a lot of generative 2d art stuff, and Processing was one of the pioneers in this area, created in back in 2001, but I've discovered it only in 2015 or even later.

It some aspects it feels like a better ActionScript, but also like a worse Java. I ended up using [p5.js](https://p5js.org/) instead because I didn't like the lack of IDE support for Processing. It has its own easy to use IDE, which is unfortunately insufficient for even middle-scale development in my opinion.

### Spreadsheet languages?

I don't know what is the name of the language inside Google Sheets, but I've used it to create useful things, including some auxiliary stuff for work. It is a programming language, so technically it counts, but it's not really in the spirit of the list above, so I put it here instead.

## Shiny things I want to touch in the future

### Rust

Can't think of anything I would need it for yet. But having a job where I would need it sounds so-o-o nice. Maybe it's a trap, like my initial fascination with Scala, but even Scala seems like it turned out nicely after all.

### OCaml, Elixir, Gleam

For no particular reason other than being very interesting languages, each in its own way.

## Write your own list

Seriously.

It is not only useful when you're looking for a job. Not just for filling a `{YOUR_NAME}_CV.pdf`, but also because condensing your experience allows you to look at your life as a whole, in case programming is something you do for a long time, like I do.

Looking at this list, I can see what makes me excited about being a programmer. Sometimes I forget. What used to be fun is now just yet another job. It doesn't have to be this way.

I want to see the purpose.
