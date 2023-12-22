#!/bin/bash

count=$(checkupdates | wc -l)

if [ $count -eq 0 ]; then
  exit 0
else
  echo "📦 $count update(s)"
fi
