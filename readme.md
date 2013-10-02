
WIP/mostly an idea.

# Idea for using gpg for sharing data for programs

Basically, each gpg private key is an user identity in the system, and it can 
sign/sign&encrypt-for-some-person(s) files to send data for programs.

The point is to have programs able to use these identities and get and send data
as identities, and all use the same transport 'moments'/medium.

This data is a tarball and each user gets a directory where these tarballs are
expanded. Each program gets a directory those user directoires. The programs run,
looking at their directories for the different users and can then make new output 
that go in the same sort of directories that were obtained. This tool can then be 
used to create a file that others can then use in the same way.

Of course it doesnt need to be a user-user sharing. You could also have an 
'aggegrator user identity' that users submit too, and it automatically forms
'opinions' of its own. Or it anonymizes by putting stuff under its own identity.
Here opinions is a bit vague; examples:(well some of these -especially the 
first three- can be unified)

* Voting system for links. A bit like reddit.
* System for keeping track of comments/discussion, voting system for it.
  Will put project for that under directory here, kindah want a commenting system
  that works everywhere.(also on source code for instance -zero-threshhold feedback)
  This might also be a suggestion for Wayland developpers; make addons for gui
  applications too, and allow all programs to provide URLs at any point.
* Voting system for decisions.
* Polls/votes for decisions.
* Results..
  + Of simulations or some such. For instance something like sharing bots from
    DarwinBots or Electric Sheep screen saver. Or maybe more serious things.
  + Of games between people.
* Things i havent thought about.

Currently the system does not care nor bother about how files are distributed;
there are plenty of ways to do that. Probably later i'll want a program that
identifies files in for instance emails, getting with http.
(having a browser plugin that identifies and can download them.)

## TODO

* The `$STORE/self/` directory should be able to contain multiple identities
the user owns.

* Files/directories might not be the best way to get some kind of performance.
  Presumably (part -the other is ways of accessing it) of the reason databases
  exist is because filesystems arent always efficient. 
  (But tarballs are fairly efficient in transit?)

* Test scripts.(see `test/readme.md`)

## License
The bash shellscripts are currently public domain. Comment anywhere is GPLv2.
