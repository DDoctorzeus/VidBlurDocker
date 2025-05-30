FROM nvidia/cuda:12.3.2-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install system dependencies
RUN apt-get update && apt-get install -y \
    tzdata \
    python3 python3-pip \
    libgl1 \
    libglib2.0-0 \
    libsm6 libxext6 libxrender-dev \
    git curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3 as default
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install Python packages
RUN pip install --upgrade pip

# Mediapipe requires these versions of dependencies
RUN pip install \
    opencv-python \
    mediapipe \
    numpy

# Copy your Python script into the container
COPY blurcam.py /blurcam.py

# Default command
CMD ["python", "/blurcam.py"]