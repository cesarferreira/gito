# gito
[![Gem Version](https://badge.fury.io/rb/gito.svg)](https://badge.fury.io/rb/gito)
[![Build Status](https://travis-ci.org/cesarferreira/gito.svg?branch=master)](https://travis-ci.org/cesarferreira/gito)
[![Code Climate](https://codeclimate.com/github/cesarferreira/gito/badges/gpa.svg)](https://codeclimate.com/github/cesarferreira/gito)
[![Inline docs](http://inch-ci.org/github/cesarferreira/gito.svg?branch=master)](http://inch-ci.org/github/cesarferreira/gito)

git helper tool to **clone**/**open**/**install**/**edit** a git project with a one-liner

> gito **cesarferreira/dryrun**

// INSERT SCREENSHOT

Will save you this repetitive work:
```bash
# clone it
git clone http://github.com/cesarferreira/dryrun

# change directory
cd dryrun

# open an editor of choice if --editor flag
atom .

# open the folder if --open flag
open .

# find out what kind of project it is
project_type_detector

# because `ruby` was detected
bundle install
```

## Usage

```bash
# git clone and enter the project folder
gito cesarferreira/dryrun

# git clone and enter the project folder and edit the project
gito cesarferreira/dryrun -e

# git clone and enter the project folder, open and edit the project
gito cesarferreira/dryrun --edit --open

# git clone from github and enter the folder
gito https://github.com/cesarferreira/dryrun

# git clone from github and enter the folder
gito https://bitbucket.org/cesarferreira/project
```

## Why?
A lot of times I find myself wanting to try some code from github and in order to do so I have to copy the git URL, go to the terminal , and based on the type of project I need to `bundle install`, `./gradlew assemble`, `npm install`... Not anymore!


## Contributing
I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request. Here are some basic rules to follow to ensure timely addition of your request:
  1. If its a feature, bugfix, or anything please only change code to what you specify.
  2. Please keep PR titles easy to read and descriptive of changes, this will make them easier to merge :)
  3. Pull requests _must_ be made against `develop` branch. Any other branch (unless specified by the maintainers) will get rejected.
  4. Check for existing [issues](https://github.com/cesarferreira/gito/issues) first, before filing an issue.
  5. Have fun!

### Created & Maintained By
[Cesar Ferreira](https://github.com/cesarferreira) ([@cesarmcferreira](https://www.twitter.com/cesarmcferreira))
