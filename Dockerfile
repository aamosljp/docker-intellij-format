FROM debian:latest

RUN apt-get update && \
    apt-get install -y wget tar libfreetype6-dev && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
RUN wget https://download-cf.jetbrains.com/idea/ideaIC-2023.3.2.tar.gz -O /tmp/intellij.tar.gz -q && \
    mkdir -p /opt/intellij && \
    tar -xf /tmp/intellij.tar.gz --strip-components=1 -C /opt/intellij && \
    rm /tmp/intellij.tar.gz

# Dirty trick to remove the IntelliJ configuration directory created on the fly
RUN echo 'rm -rf ?' >> /opt/intellij/bin/idea.sh

WORKDIR /data

ENTRYPOINT ["/opt/intellij/bin/format.sh"]
