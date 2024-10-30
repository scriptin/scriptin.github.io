---
layout: post
title: All the programming languages I have ever used
published: false
---
At the moment of writing this I'm actively looking for a job, and it is often asked to provide an experience for a certain language, framework, or library in application forms. Filling those forms and thinking about it later has brought back some memories, both dear and horrifying, which I've decided to write down.

I've included a programming language if it matches one of the following criteria:

1. I've used it as part of my (paid) job, full- or part-time, or a one-off project, or otherwise made any money from it.
2. I've used it in a personal project of any size and any purpose, as long as the purpose was not simply to try the language. I've completed the said project to some arbitrary definition of done.

Only programming languages are included. I omit languages like CSS, XML, JSON, etc. Arguably, you can write code in some of those, but it's not their primary purpose.

## The list

### ActionScript

In the era of Flash, I've created a rope physics simulation demo in ActionScript, and I vaguely remember creating at least one tiny Flash game.

When I graduated from high school, one of my exams was Informatics (as they were calling the basics of Computer Science), and I have created my presentation in Flash instead of MS PowerPoint. I don't think anybody noticed, but I told my friend, and that really mattered.

ActionScript was not even that bad, despite the fact that it was mostly used to create trashy games.

### Assembly (x86)

Used at least once to create an ASCII-art program when I was a kid because it sounded cool. It still sounds cool, actually.

In university, I used Asm multiple times in parts of programs written in Pascal and Delphi, with an intent to make critical parts more performant. Whether there were any performance gains is an open question, as I didn't do any profiling.

### C

I had a university course on C++, but what was actually taught was C syntax without any C++ features. At least, I don't remember using any C++ features in my course projects, so I wouldn't count this as using C++. I've written several programs during the course, which, despite their insignificance, were complete projects.

C++ was actually the first language I've ever *tried* to learn at the age of 15 or so, but I quickly gave up because it was too difficult, so I don't count it.

### C#

I also had a university course on C#, and unlike C/C++, I've actually used C# to write useful programs.

The first program I've sold was in C#. I don't remember the exact price, but it was in US$20-40 range (equivalent in Russian rubles). The program was a [15 puzzle](https://en.wikipedia.org/wiki/15_puzzle) implementation with GUI. And it was a course work for another student which they were supposed to do during the whole semester, so I felt proud and bad (because I helped them cheat) at the same time.

### Delphi

Delphi was the first programming language which I used extensively to write multiple useful programs. I can barely remember them, but one notable mention was a tool for converting low resolution images into [cross-stitching](https://en.wikipedia.org/wiki/Cross-stitch) schemes. I was probably around 17-19 years old at that time.

### Java

I have multiple years of professional experience writing Java code for web applications, mostly based on Spring framework in Java versions 6-9. I've also used Hibernate, Apache Wicket, and some other stuff I barely remember.

Can't say I like Java, but it had opened nice remote job opportunities, and also switching from PHP felt really empowering. I barely understood what I was doing at first, but I dug deep and learned rapidly.

### JavaScript

The language I have used the longest. Probably first tried it at the age of 15, and use it extensively until this day. Most of the code I've written during the last few years is either JS or compiled into it (see TypeScript below).

Besides JavaScript in web browsers and Node.js, I've played with its cousin language JScript on Windows, for the purposes of automation and creating silly prank scripts.

JavaScript is the language I think in at this point. It's neither good nor bad, it just *is*.

### Kotlin

Haven't used it on any of my full-time jobs, bat have several personal FOSS projects written in it, most importantly [jmdict-simplified](https://github.com/scriptin/jmdict-simplified). One of the coolest languages on this list in my opinion.

### Pascal

Mostly the same experience as with Delphi. Many of the programs I've written in Delphi (especially CLI tools) could have been ported to Pascal, but I've also used Turbo Pascal compiler directly during my CS course in university.

### PHP

My first full-time job was writing websites in PHP along with HTML+JS+CSS. I hated it quite a lot, but it paid the bills.

Most of my experience was either writing plain PHP scripts or working with CMSs like Drupal, Joomla, and WordPress, but I've tried a couple of frameworks as well, namely Kohana and Yii.

### Python

Besides several utility scripts, I've used Python for NLP tasks recently, and I find it quite comfortable to work with.

Python was also the language I've used to teach the basics programming to my friends and family members, with modest success.

### Scala

At the same time I've been doing Java full-time, I had several Scala projects, and the language felt very exciting at first. Then, after experiencing all the complexity hidden in the language itself and its tooling, I became too tired of it to continue using it for anything. But lately, I'm seeing Scala having a renaissance with its version 2.0, so I might try it again someday.

### Shell scripts (bash, zsh)

I hate every second of it, but it works (except when it doesn't). Small scripts I've written for switching between different version of Java and Tomcat were horrible, but made me productive when it was necessary.

### Solidity

One Ethereum smart contract written and deployed. Yes, it was related to NFTs. No, I haven't made any money from it. Cool language nonetheless because it really pushes you to think out of the box, into a different box.

### SQL

MySQL, Postgres, SQLite, and a little bit of MS SQL Server. Most web apps need databases, and most databases I've worked with were relational.

I've always treated SQL dialects as "chore" languages, but to be honest they are one of the most important in my career and deserve more love and attention.

### Swift

I've used it in exactly one project, and liked it quite a lot. Unfortunately, it came with horrible XCode tooling and no dependency manager, but I judge the language by itself.

### TypeScript

I was quite an early adopter, starting as early as 2014 (maybe 2015, but it was v1.0), and I didn't like it at first, but now it's my default language for anything web-related. In small personal projects, I still often use JavaScript, but the rise of Deno, Bun, and generally improving support of TypeScript turns the tide.

This language is the one which brought me the most relief because it makes working on bigger JS projects not just possible, but often actually pleasant.

### XQuery

Not to be confused with jQuery.

My [jmdict-simplified](https://github.com/scriptin/jmdict-simplified) project was written in JQuery until v3.2.0. This is the most "esoteric" language I've ever used, and I must say I was positively impressed. It's a domain-specific language, and quite a smart one in my opinion.

The reason for migrating jmdict-simplified to Kotlin was the fact that I've run into memory limits since XQuery does not support streaming processing of XML. For smaller XML files, it is viable and even quite good as long as you use a right implementation of it (I've settled on [BaseX](http://basex.org/)).

## Honorable mentions

### Haskell

While I haven't really finished any "project" in Haskell, I've made multiple attempts at learning it on my own (using **[Learn You a Haskell](https://learnyouahaskell.com/)**), and had a few running hello-worlds showing various features. Unlike my C/C++ university course, I haven't even used Haskell for the purpose of passing an exam. Unfortunately, it was not on the curriculum.

### Lisp (Scheme)

I've accidentally written more than one pair of properly nested parentheses once. Just kidding. I've used several Lisp dialects for learning purposes, namely to go through the **[Structure and Interpretation of Computer Programs (SICP)](https://books.scheme.org/)**. Don't remember anything from it now, but it was fun.

### Lua

I've used to play with some 2D game engines in Lua. Can't remember any finished projects though. More importantly, it was a part of some Minecraft mod (I think it was ComputerCraft), and I've programmed bots to dig quarries.

### Spreadsheet languages?

I don't know what the name of the language inside Google Sheets, but I've used it to create useful things, including at work, but not directly for the work purposes. It is a programming language, so technically it counts, but it's not really in the spirit of the list above, so I put it here instead.

## Shiny things I want to touch in the future

### Rust

Oh, yeah... Can't think of anything I would need it for yet. But having a job where I would need it sounds so nice. Maybe it's a trap, like my initial fascination with Scala, but even Scala seems like it turned out nicely after all.

### OCaml, Elixir, Gleam

For no particular reason other than being very interesting languages.

## Write your own list

Seriously. It is not only useful when you're looking for a job. Not just for filling a `{YOUR_NAME}_CV.pdf`, or answering application form questions with more precise dates, but also because condensing your experience allows you to look at your life as a whole, in case programming is something you do for a long time, like I do. Making career turns requires having some perspective, but there's something more important.

Looking at this list, I can see what makes me excited about being a programmer. Sometimes I forget. What used to be fun is now just yet another job. It doesn't have to be this way.

I want to see the purpose.
