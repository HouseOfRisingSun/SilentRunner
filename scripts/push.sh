#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm use default
#rm -rf ~/.cocoapods/repos/master
pod setup
pod lib lint --use-libraries --allow-warnings SilentRunnerEngine.podspec
pod trunk push --use-libraries --allow-warnings
