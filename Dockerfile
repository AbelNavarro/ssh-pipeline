# The published image (.github/workflows/image.yml) is built FROM the base
# pinned by digest; the default is for local builds. mirror.gcr.io serves
# Docker Hub's official images without Docker Hub's anonymous pull limit.
ARG BASE_IMAGE=mirror.gcr.io/library/python:3.13-slim
FROM ${BASE_IMAGE}

LABEL "maintainer"="Scott Ng <thuongnht@gmail.com>"
LABEL "repository"="https://github.com/cross-the-world/ssh-pipeline"
LABEL "version"="v1.3.0"

LABEL "com.github.actions.name"="ssh-pipeline"
LABEL "com.github.actions.description"="Pipeline: ssh"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="gray-dark"

RUN apt-get update -y && \
  apt-get install -y ca-certificates openssh-client openssl sshpass

COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

RUN mkdir -p /opt/tools

COPY entrypoint.sh /opt/tools/entrypoint.sh
RUN chmod +x /opt/tools/entrypoint.sh

COPY app.py /opt/tools/app.py
RUN chmod +x /opt/tools/app.py

ENTRYPOINT ["/opt/tools/entrypoint.sh"]
