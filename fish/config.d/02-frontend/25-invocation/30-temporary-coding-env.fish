#/usr/bin/env fish
#
# Creates a temporary project folder in the /tmp directory, set up for a given
# language using the tmpcode command.
#
# The location is consistently /tmp/tmpcode-<lang>-<number>
# where lang is the language and number is an incrementing number
# that only increments when tmpcode is called a second time with
# the same language, and --new is specified. Otherwise the old
# environment is reused.
#
# tmpcode rust               Use the rust environment with no number, creates it if it doesn't exist
# tmpcode rust new           Make a new rust environment
# tmpcode rust 3             Use the third rust environment
# tmpcode rust list          List all rust environments
# tmpcode rust clean         Delete all rust environments
# tmpcode rust rm <num>      Delete a specific rust environment.



