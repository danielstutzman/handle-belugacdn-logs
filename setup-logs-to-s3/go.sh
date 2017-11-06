#!/bin/bash -e
rbenv local `cat .ruby-version`
if [ ! -e vendor/bundle ]; then
  bundle install --path vendor/bundle
fi
./setup_aws.sh
bundle exec ruby test-upload.rb
