#!/bin/sh
if pgrep -f "ffmpeg.*x11grab" >/dev/null; then
    printf "⏺ REC"
fi