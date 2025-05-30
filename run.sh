#!/bin/sh

#Create the virtual device first!!
#sudo modprobe v4l2loopback video_nr=10 card_label="BlurCam" exclusive_caps=1

#Run example (replace video0 with actual video)
docker run --rm \
  --gpus all \
  --device=/dev/video0 \
  --device=/dev/video10 \
  --network=host \
  blurcam