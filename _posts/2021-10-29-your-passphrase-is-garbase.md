---
layout: post
title: "Your passphrase is garbage"
last_updated: 2023-10-11
---

> TL;DR: Passphrases are better than passwords, but not sustainable. Use a password manager to generate and store long, truly random passwords, and remember just one passphrase - your password manager's master passphrase.

## Passwords are bad

Imagine you're about to create a new account, and to set a password, you need to provide a string of characters which:

- is at least 8 characters long
- contains at least one symbol in each of these categories:
  - lowercase letters
  - uppercase letters
  - numbers
  - special characters: `!@#$%^&*()-_=+,.<>/?`

Here's one:

> Passw0rd!

The problem? It's in a dictionary which hackers use to brute-force passwords (see [this collection](https://github.com/danielmiessler/SecLists/tree/master/Passwords) for examples of such dictionaries), so it's not secure.

A better one?

> John$mith1980

(Imagine your name is John Smith, and you're born in 1980.)

Not much better. Not in a dictionary, probably, but hackers can gather your personal information. Maybe you think that you're not that important, but your data may appear in a data breach or gathered automatically from you social network profiles, so you don't have to be important to fall victim to hackers.

## Let's try passphrases

Some people and companies (even those in cyber-security industry) [recommend](https://www.youtube.com/results?search_query=passphrase) to use _passphrases_ instead, with a typical instruction for creating one looking something like this:

1. Think of a long phrase: "I met Jane in New York in 1995"
2. Use only initial letters: `ImJiNYi1995`
3. Replace some with special characters: `ImJ@NY#1995`

Looks good? Better indeed, but...

## Can you remember a passphrase?

Imagine that you don't use this passphrase for more than a month. Also, you have multiple accounts which use passphrases created with the same technique. Eventually, you'll either forget the whole thing, or at least which exact letters you've replaced with symbols.

No problem, you can simply reset your password. You'll have to go through the process of creating a new passphrase though.

Then, you'll forget it again, and reset it again. And again. Until, eventually, you will _reuse_ the same passphrase for multiple accounts, or fallback to weaker passwords which you can actually remember. Or put a sticker on your monitor. Goodbye, security.

## Sustainable option: password managers

The password/passphrase strength is only half of the story. The other half is managing your secrets, and it's actually the harder one. The stronger a password is, the easier it is to forget, as human brains aren't exactly good at remembering strings of random characters. Add the number of your accounts to the equation, and you'll quickly realise that the only way to remember all your secrets is to... not remember them!

Let a machine do the mechanical work. Or rather, a program - a password manager. I will not recommend anything specific here, but I tried a few password managers and at the moment I'm using [Bitwarden](https://bitwarden.com/). Do your own research. Think about [the infamous LastPass breach](https://blog.lastpass.com/2023/03/security-incident-update-recommended-actions/) and remember that "paid" is not necessarily better.

## My ultimate guide to password management

1. Create just one **very strong** passphrase for your password manager's **master password** using the technique described above. This is the only one you need to remember! Make sure you initial phrase is not easily guessable:
    - do not use your favourite quote which is printed on your t-shirt;
    - do not use any personal information;
    - do not mention you hobbies/interests in that phrase, try to make it as unrelated to you as a person as possible - as long as you can still remember it.
2. Put **all** of your passwords in your password manager. May sound like a daunting task, but you don't have to do it all at once. Make a habit of migrating your accounts to your password manager every time you need to re-login or reset your password.
3. Make sure to generate long and truly random passwords using tools in your password manager (it should have a generator).
4. Make sure to replace your old weak passwords with randomly-generated ones. Again, you don't have to do it all at once.
5. Use the 2-factor authentication (2FA, or [Multi-factor authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication), MFA) apps like [Authy](https://authy.com/), Google Authenticator, etc. **for your password manager** and for other important accounts, such as your email, social networks, etc. Your master password alone is not enough! You absolutely need 2FA/MFA for all important accounts, and your password manager account is you most valuable one.
6. Make sure to securely back up your passwords. Typically, password managers (and some 2FA/MFA apps like Authy) provide a cloud option, and some are even free (like Bitwarden). Make sure that whichever backup option you're using, it must be encrypted and stored in a place which makes sense, i.e. not on a same laptop where your password manager is installed.
7. Periodically check your accounts with [haveibeenpwned.com](https://haveibeenpwned.com/) or similar services/tools (some password managers offer that as a service, typically paid), and update passwords for any leaked accounts, even if you think that a password wasn't compromised. Most big companies will notify you about data breaches, but don't expect for-profit corporations to be timely and responsible with their disclosures. Your security is your responsibility.

Remember: your memory is not a reliable place to store random strings, and you're not as good at creating random strings as you might think. Install a damn password manager now!
