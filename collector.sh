#!/bin/bash
AUTHLOG=/var/log/auth.log

if [[ -n $1 ]];
then
  AUTHLOG=$1
  echo Using Log file : $AUTHLOG
fi

# Collect the failed login attempts
FAILED_LOG=/tmp/failed.$$.log
egrep "Failed pass" $AUTHLOG > $FAILED_LOG

# Collect the successful login attempts
SUCCESS_LOG=/tmp/success.$$.log
egrep "Accepted password|Accepted publickey|keyboard-interactive" $AUTHLOG > $SUCCESS_LOG

# extract the users who failed
failed_users=$(cat $FAILED_LOG | awk '{ print $(NF-5) }' | sort | uniq)

# extract the users who successfully logged in
success_users=$(cat $SUCCESS_LOG | awk '{ print $(NF-5) }' | sort | uniq)

