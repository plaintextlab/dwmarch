#!/usr/bin/env bash

trap 'kill -TERM $PPID; exit' INT TERM EXIT

while true; do
    PID=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu \
        | awk 'NR==1 || NR>1 {printf "%-8s %-8s %-6s %-6s %s\n",$1,$2,$5,$4,$3}' \
        | column -t \
        | fzf --header="PID PPID CPU% MEM% COMMAND (ENTER=kill, CTRL-C=exit)" \
        | awk '{print $1}')

    [ -z "$PID" ] && exit

    kill -9 "$PID"
done