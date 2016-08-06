#!/bin/sh
# Scriptacular - gemify.sh
# Create a Ruby gem and push it to rubygems.org
# Copyright 2013 Christopher Simpkins
# MIT License

# Enter your gem name below (do not enter version number)
# or pass it as the first argument to the shell script
GEM_NAME="rapid_runty"

# Don't touch these
GEMSPEC_SUFFIX=".gemspec"
GEM_BUILD_CMD="gem build"
GEM_PUSH_CMD="gem push"

# run the gem build and parse for the gem release filename
GEM_BUILD_NAME=$(gem build "$GEM_NAME$GEMSPEC_SUFFIX" |  awk '/File/ {print $2}' -)

# if above succeeded, then push to rubygems.org using the gem that was compiled
gem push $GEM_BUILD_NAME -k $RUBYGEMS
exit 0
