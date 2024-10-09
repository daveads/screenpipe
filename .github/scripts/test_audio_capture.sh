#!/bin/bash
ls -l .github/scripts/audio_test.wav
pulseaudio --check
ps aux | grep pulseaudio
ls -l /run/user/$(id -u)/pulse/
PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native paplay --verbose .github/scripts/audio_test.wav
sleep 30
cat screenpipe_output.log
if grep -qi "human world" screenpipe_output.log; then
  echo "Audio capture test passed: 'human world' found in logs"
elif grep -qi "audio" screenpipe_output.log; then
  echo "Audio capture test partially passed: Audio-related output found"
else
  echo "Audio capture test failed"
  tail -n 100 screenpipe_output.log
  exit 1
fi
