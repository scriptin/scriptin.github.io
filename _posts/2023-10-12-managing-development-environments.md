---
layout: post
title: "Managing development environments: through the spectrum"
---

## The search

My programming journey started in the mid-2000s, and I've tried almost all imaginable ways of managing my dev environments. I was never really happy with the results, but I've learnt a lot in the process.

In my PHP days, I've used [XAMPP](https://en.wikipedia.org/wiki/XAMPP) and similar packages most of the time.  Sometimes, a production server was my dev environment, usually with a separate hidden copy of an app, but sometimes just modifying the main instance directly. I kid you not - I was once in a small team where deployments consisted of copying files to a server using an FTP client without any version control.

When I've switched to Java later, I've used to install everything manually on my machine, then automating some parts. I remember having a bash script for switching between Tomcat server versions, but most of other parts, like a database server, were not configurable.

I've played extensively with virtual machines. I've only seen one person using them for development on their full-time job, and I've never done this myself for any production stuff. But I've tinkered with [Vagrant](https://www.vagrantup.com/) and [Chef](https://www.chef.io/) in my free time enough to understand that, despite all the advantages, it was too unwieldy for everyday development.

## Docker

Then came Docker. It had all the pros of virtual machines, without many cons:

1. It was isolated, avoiding version conflicts;
2. It was secure, if configured properly;
3. It was sufficiently fast to spin up, shut down, and rebuild;
4. The learning curve was similar to using Vagrant and other provisioning tools, although there was no option of manual setup like with a regular VM, but this is not a problem if you're looking for a reproducible environments and will configure with code anyway.

Later, as it became a ubiquitous deployment solution, it also erased the distinction between dev and prod environments, making the infamous "it works on my machine" excuse a thing of the past.

But it seems that there's indeed no free cheese. After making some [big mistakes](https://blog.alexellis.io/docker-is-deleting-open-source-images/) and then [apologizing](https://www.docker.com/blog/we-apologize-we-did-a-terrible-job-announcing-the-end-of-docker-free-teams/), Docker no longer seem like a trustworthy option for open-source software projects.

## Nix and Devbox

I'm not an OSS maximalist - in fact, I use IntelliJ IDEA (ultimate edition) as my IDE for almost everything, and I'm quite happy to pay for the developer experience, stability, and features it provides. As an aside rant, I'm very skeptical about VSCode because I don't want my whole dev stack to depend on one company - GitHub, NPM, TypeScript are all under Microsoft, and if I would switch to Windows and VSCode, Microsoft would have way too much influence on my career and life. (End of rant.)

This blog used to use Docker for local development, but a few days ago I've switched to [Devbox](https://www.jetpack.io/devbox/). I've yet to find the (unavoidable) disadvantages, but so far it looks like a good compromise between using Nix package manager directly (which is powerful, but not beginner-friendly) and a product managed by a single entity. Jetpack.io - the maker of Devbox - is a small company, so there are some associated risks, but still it looks like a relatively safe bet. At least the underlying Nix [is developed by a community](https://nixos.org/community/).

I extensively use things like [nvm](https://github.com/nvm-sh/nvm) or [conda](https://docs.conda.io/en/latest/), but they only solve a part of the problem:

| Solution         | OS type? | Binary dependencies? | Language versions? |
|------------------|----------|----------------------|--------------------|
| VM, Vagrant      | YES      | YES                  | YES                |
| Docker           | NO       | YES                  | YES                |
| Nix, Devbox      | NO       | YES                  | YES                |
| nvm, conda, etc. | NO       | NO                   | YES                |

_Note_: "Binary dependencies" include things like DB servers, utilities like curl, etc.

The table omits many important aspects, such as security, but the purpose is to demonstrate that you can't simply replace Docker with tools like nvm/conda, while Devbox is a valid option to consider.

## Why not just Nix?

Nix is a complex tool, and I've had a few minor attempts to figure it out. It's difficult, but manageable. Git was hard for me to figure out as well, but now I use it for everything.

My introduction to Nix was a result of simple curiosity, but later I've tried to use it for the development of smart contracts in Haskell on the [Cardano](https://cardano.org/) blockchain. Due to my life circumstances, I've eventually lost interest in the blockchain technologies and cryptocurrencies, but Nix was still on the back-burner.

Devbox is not a way to avoid Nix, but rather a way to get into Nix more gently. When a task is big and scary, I split it into small parts.

## Also, the cloud

In recent years, many cloud-based solutions for the dev environments problem have emerged. Just to mention a few: [Space from JetBrains](https://www.jetbrains.com/space/), [Codespaces from GitHub](https://github.com/features/codespaces), [Cloud9 from AWS](https://aws.amazon.com/pm/cloud9/), [Gitpod](https://www.gitpod.io/), etc.

My opinion is that all these services are okay to use in a corporate setting, but for open-source we need to remember the stories of the aforementioned Docker, [Unity runtime fee](https://en.wikipedia.org/wiki/Unity_(game_engine)#Runtime_fee), [Reddit API changes](https://en.wikipedia.org/wiki/2023_Reddit_API_controversy), and many more. I've extracted one important wisdom from all of those - when a for-profit company does something for free with no _obvious_ monetization plan, they either have a [secret, malicious plan](https://en.wikipedia.org/wiki/Embrace,_extend,_and_extinguish), or no plan at all, which usually leads to a catastrophe.

If you work for a corporation, it's the corporation's job to avoid any potential vendor lock-ins. If you work on an open-source project, it's _your_ job. That's why I think Devbox is fine - it's based on Nix, so in case of emergency, I could probably figure out how to migrate.

If you still want to try out a cloud environment, at least pick the least evil vendor.

## Conclusion

I'll still use Docker when I need to, and I'll still use the products of Microsoft and GitHub. Being a maximalist is something I cannot afford. But I've learnt my lessons to not put all eggs into one basket, to not put all hope into one corporation (and, for that matter, any philosophy, idea, or a government).

Do some research, pick whatever makes the job done, and hope to not get screwed by the corporate greed.
