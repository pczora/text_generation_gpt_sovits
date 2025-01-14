ARG DOCKER_FROM=docker.io/pczora/text-generation-base:0.0.1_v0.13

# Base NVidia CUDA Ubuntu image
FROM $DOCKER_FROM AS base
ARG GPT_SOVITS_REPO_URL="https://github.com/pczora/GPT-SoVITS.git"
ARG GPT_SOVITS_REF="rest_api"

SHELL ["/bin/bash", "-c"]
WORKDIR /root

ENV CB=0
RUN apt-get update -y && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone $GPT_SOVITS_REPO_URL && \
    cd GPT-SoVITS && \
    git checkout $GPT_SOVITS_REF && \
    mkdir -p GPT_SoVITS/pretrained_models && \
    git clone https://huggingface.co/lj1995/GPT-SoVITS /tmp/models && \
    cp -r /tmp/models/* GPT_SoVITS/pretrained_models && \
    python3 -m venv env && \
    source ./env/bin/activate && \
    pip3 install --no-cache-dir -r requirements.txt && \
    pip3 install --no-cache-dir flask && \
    pip3 install --no-cache-dir gunicorn && \
    python -m nltk.downloader averaged_perceptron_tagger_eng && \
    deactivate

WORKDIR /
COPY --chmod=755 start-with-ui.sh /start-with-ui.sh
COPY --chmod=755 start.sh /start.sh
COPY --chmod=755 start-gpt-sovits.sh /start-gpt-sovits.sh
WORKDIR /workspace
CMD [ "/start.sh" ]
