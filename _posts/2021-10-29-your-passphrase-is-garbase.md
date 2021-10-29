---
layout: post
title: "Your passphrase is garbage"
---

> TL;DR: Use a password manager. You should only have 1 passphrase to remember: your password manager's master passphrase. See the guide at the end for more tips.

## Passwords are even more garbage

Imagine you're about to create a new account, and to set a password, you need to provide a string of characters which:

- is at least 8 characters long
- contains at least one of each of these:
  - lowercase letter
  - uppercase letter
  - number
  - special character: `!@#$%^&*()-_=+,.<>/?`

Here's one:

> Passw0rd!

The problem? It's in a dictionary which hackers use to brute-force passwords.

A better one?

> John$mith1980

(Imagine your name is John Smith, and you're born in 1980.)

Not really. Hackers can gather your personal information. Maybe you think that you're not that important, but your data may appear in a data breach or be gathered automatically from you social network profiles, so you don't have to be important to fall victim to hackers.

## Passphrases?

Some people and companies (even those in cyber-security industry) [recommend](https://www.youtube.com/results?search_query=passphrase) to use _passphrases_ instead:

1. Think of a long phrase: "I met Jane in New York in 1995"
2. Use only initial letters: `ImJiNYi1995`
3. Replace some with special characters: `ImJ@NY#1995`

Looks good? Not really.

## Passphrases are advertised as a better option, but...

Imagine that you don't use this passphrase for more than a month. Also, you have multiple accounts which use passphrases created with a same technique. Eventually, you'll either forget the whole thing, or at least which letters you've replaced with symbols.

You'll end up resetting your password, no problem.

Then, you'll forget it again, and reset it again. And again. And again. Until, eventually, you will _reuse_ a passphrase for multiple accounts or fallback to a weak password. You're now back to square one in terms of security.

## Sustainable option: password managers

The problem is that the strength of your password/passphrase is only half of it. The other half is managing your secrets. The stronger the password is, the harder it is to remember. Add the number of your account to the equation, and you'll quickly realise that the only way to remember all your passwords/passphrases is to... not remember them.

I will not recommend anything here, but I tried a few and at the moment I'm using [Bitwarden](https://bitwarden.com/), but I encourage you to do your own research.

## My ultimate guide to password management

1. Create just one **very strong** passphrase for your password manager's **master password** using the technique described above. This is the only one you need to remember! Make sure you initial phrase is not easily guessable:
    - do not use your favourite quote which is printed on your t-shirt
    - do not use any personal information
    - do not mention you hobbies/interests in that phrase, try to make it as unrelated to you as a person as you can (as long as you can still remember it)
2. Put **all** of your passwords in your password manager. At least, eventually.
3. Make sure to generate long and truly random passwords using the generator tool in your password manager (it should have one).
4. Make sure to replace your old weak passwords with generated ones.
5. Use 2-factor authentication (2FA, see [Multi-factor authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication)) (apps like [Authy](https://authy.com/), Google Authenticator, etc.) **for your password manager** and for other important accounts, such as your email, social networks, etc. Your master password alone is not enough! You absolutely need 2FA for all important accounts, and your password manager account is you most valuable one.
6. Make sure to securely back up your passwords. Typically, password managers (and some 2FA apps, like Authy) provide that option, and some are even free (like Bitwarden). Make sure that whatever backup option you're using, it must be encrypted and stored in a place which makes sense (i.e. not on a same laptop where your password manager is installed).
7. Periodically check your accounts with [haveibeenpwned.com](https://haveibeenpwned.com/) or similar services/tools (some password managers offer that as a service, typically paid), and update passwords for your leaked accounts, even if you think that passwords were not compromised. Most big services will notify you about data breaches, but your security is your responsibility.
