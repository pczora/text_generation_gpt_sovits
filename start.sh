#!/bin/bash

/start-styletts2.sh &
/start-gpt-sovits.sh &

# Wait for any process to exit
wait -n
exit $?