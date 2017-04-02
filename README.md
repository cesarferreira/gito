# gito
[![Gem Version](https://badge.fury.io/rb/gito.svg)](https://badge.fury.io/rb/gito)
[![Build Status](https://travis-ci.org/cesarferreira/gito.svg?branch=master)](https://travis-ci.org/cesarferreira/gito)
[![Code Climate](https://codeclimate.com/github/cesarferreira/gito/badges/gpa.svg)](https://codeclimate.com/github/cesarferreira/gito)
[![Inline docs](http://inch-ci.org/github/cesarferreira/gito.svg?branch=master)](http://inch-ci.org/github/cesarferreira/gito)

git helper tool to **clone** && **open** && **install** && **edit** a git project with a one-liner

> gito **cesarferreira/dryrun** --edit

Will
```bash
git clone http://github.com/cesarferreira/dryrun # clone it
cd dryrun # change directory
project_type_detector # find out what kind of project it is
bundle install # because ruby was detected
atom . # because it's your editor of choice
```

## Why?
A lot of times I find myself wanting to try some code from github and in order to do so I have to copy the git URL, , and based on the type of project I need to `bundle install`, `./gradlew assemble`, `npm install`... Not anymore!


## Contributing
I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request. Here are some basic rules to follow to ensure timely addition of your request:
  1. If its a feature, bugfix, or anything please only change code to what you specify.
  2. Please keep PR titles easy to read and descriptive of changes, this will make them easier to merge :)
  3. Pull requests _must_ be made against `develop` branch. Any other branch (unless specified by the maintainers) will get rejected.
  4. Check for existing [issues](https://github.com/cesarferreira/gito/issues) first, before filing an issue.
  5. Have fun!

### Created & Maintained By
[Cesar Ferreira](https://github.com/cesarferreira) ([@cesarmcferreira](https://www.twitter.com/cesarmcferreira))
