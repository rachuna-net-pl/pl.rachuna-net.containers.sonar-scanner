FROM ubuntu:noble

ARG CONTAINER_VERSION="0.0.0"

LABEL Author='Maciej Rachuna'
LABEL Application='pl.rachuna-net.containers.sonarqube-scanner'
LABEL Description='sonarqube-scanner container image'
LABEL version="${CONTAINER_VERSION}"

COPY scripts/ /opt/scripts/

# Install required packages
RUN apt-get update && apt-get install -y \
        ca-certificates \
        openjdk-17-jre \
        bash \
        curl \
        git \
        gnupg2 \
        jq \
        lsb-release \
        openssh-client \
        unzip \
        wget \
    # Download and install sonar-scanner
    && curl --proto "=https" -Lo sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.0.2.4839-linux-x64.zip" \
    && unzip sonar-scanner.zip -d /opt/ \
    && rm sonar-scanner.zip \
    && ln -s /opt/sonar-scanner-7.0.2.4839-linux-x64/bin/sonar-scanner /usr/local/bin/sonar-scanner \
    && sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner-7.0.2.4839-linux-x64/bin/sonar-scanner \
    && chmod +x /opt/scripts/*.bash

ENV JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

ENTRYPOINT [ "/opt/scripts/entrypoint.bash" ]

