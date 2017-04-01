# gito

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
A lot of times I find myself wanting to try some code from github and in order to do so I have to copy the , and based on the type of project I need to `bundle install`, `./gradlew assemble`, `npm install`... Not anymore!
