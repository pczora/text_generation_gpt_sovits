#!/bin/bash

mkdir -p /workspace/reference_voices
cd /root/GPT-SoVITS || exit
source /root/GPT-SoVITS/env/bin/activate
PYTHONPATH=/root/GPT-SoVITS/GPT_SoVITS:$PYTHONPATH gunicorn -b 0.0.0.0:5555 'main:app'
deactivate