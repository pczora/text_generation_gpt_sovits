#!/bin/bash

/start-with-ui.sh &
/start-gpt-sovits.sh &

# Wait for any process to exit
wait -n
exit $?