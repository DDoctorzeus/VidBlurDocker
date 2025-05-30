import cv2
import mediapipe as mp
import numpy as np

#Grab video dev for capture
cap = cv2.VideoCapture(0)
out = cv2.VideoWriter('/dev/video10', cv2.VideoWriter_fourcc(*'MJPG'), 30, (640, 480))

#Set frame blur
mp_selfie_segmentation = mp.solutions.selfie_segmentation
segmenter = mp_selfie_segmentation.SelfieSegmentation(model_selection=1)

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = segmenter.process(rgb)
    mask = results.segmentation_mask > 0.1

    blurred = cv2.GaussianBlur(frame, (55, 55), 0)
    output = np.where(mask[..., None], frame, blurred)

    out.write(output)

cap.release()
out.release()