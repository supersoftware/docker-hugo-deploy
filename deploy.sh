#!/bin/bash

set -e

cd $DEPLOY_SRC

# retrieve latest
echo "git pull or clone"
if [ ! -d $DEPLOY_SRC/.git ]
then
  git clone $GIT_URL .
else
  git pull $GIT_URL
fi

echo "checkout target branch"
git checkout $GIT_BRANCH

# build static site
echo "building with hugo"
hugo --cleanDestinationDir

# sync src with dest
echo "rsync $@"
rsync "$@"
