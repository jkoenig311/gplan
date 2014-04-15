## What is GPlan?

GPlan started out as a simple ruby script that parsed out ticket numbers
from any git log of the current branch compared to its production branch
and create puts together release notes

## Setup

    gem build gplan.gemspec
    gem install gplan-0.0.0.gem

or to install globally

    rvm @global do gem install gplan-0.0.0.gem

## Usage

Note that we make an assumption that your git remote and branch to compare to is production/master

1. cd to git project
2. checkout the branch that you wish to get release notes for
3. run `gplan`
4. you should now get a list of the pattern

```
<STORY_ID>:<STATUS>:<TITLE>
```
