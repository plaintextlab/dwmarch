#!/usr/bin/env bash

set -euo pipefail

PIDFILE="/tmp/screenrecord.pid"

# Stop recording if already running
if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
    fi
    rm -f "$PIDFILE"
    exit 0
fi

# Detect monitor resolution
RESOLUTION=$(xrandr | awk '/\*/ {print $1; exit}')

# Timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Start recording (5 minute segments)
ffmpeg \
-f x11grab \
-framerate 60 \
-video_size "$RESOLUTION" \
-i "$DISPLAY" \
-c:v libx264 \
-preset veryfast \
-pix_fmt yuv420p \
-f segment \
-segment_time 300 \
-reset_timestamps 1 \
"${HOME}/Videos/record_${TIMESTAMP}_%03d.mp4" &

echo $! > "$PIDFILE"