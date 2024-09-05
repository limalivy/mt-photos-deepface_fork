FROM python:3.8.10-buster
USER root

# COPY ./sources.list /etc/apt/sources.list
RUN apt update && \
    apt install -y libgl1-mesa-glx libglib2.0-0 libsm6 libxrender1 libfontconfig1 pkg-config libhdf5-dev python3-h5py && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/log/*

WORKDIR /app
COPY requirements.txt .

# 安装依赖包
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install ultralytics

RUN mkdir -p /models/.deepface/weights && \
    wget -nv -O /models/.deepface/weights/yolov8n-face.pt https://drive.google.com/uc?id=1qcr9DbgsX3ryrz2uU8w4Xm3cOrRywXqb && \
    wget -nv -O /models/.deepface/weights/facenet512_weights.h5 https://github.com/serengil/deepface_models/releases/download/v1.0/facenet512_weights.h5

COPY run.sh .
RUN chmod 777 run.sh
COPY server.py .
ENV DEEPFACE_HOME=/models
ENV API_AUTH_KEY=mt_photos_ai_extra
EXPOSE 8066

CMD [ "sh", "run.sh" ]
