#!/bin/bash

gawk -v FPAT='[^,]*|"[^"]+"' -v OFS='  ' '{$1=$1} 1' example.cron      ### Substitute all commas in the file with TAB except for the ones within double quotes.
