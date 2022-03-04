ARG CLI_VERSION={{cli_version}}

# Extend the Docksal CLI per https://docs.docksal.io/stack/extend-images/
FROM docksal/cli:${CLI_VERSION}

# See https://github.com/hadolint/hadolint/wiki/DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# NOTE: This only works on X86_64 Arch. 
#
# Puppeteer dependencies taken from https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#running-puppeteer-in-docker
# Install addtional apt packages needed for pa11y and puppeteer
# Add vim
# hadolint ignore=DL3015,DL3008
# RUN apt-get update && \
#   apt-get install -y wget gnupg && \
#   wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
#   sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
#   apt-get update && \
#   apt-get install -y --no-install-recommends google-chrome-stable \
#   fonts-ipafont-gothic \
#   fonts-wqy-zenhei \
#   fonts-thai-tlwg \ 
#   fonts-kacst \
#   fonts-freefont-ttf \
#   libxss1 \ 
#    && \
#   apt-get install -y vim --no-install-recommends && \
#   rm -rf /var/lib/apt/lists/*

ARG HELM_VERSION=v2.17.0

# Install kubectl and helm client
RUN curl -o /usr/local/bin/kubectl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" && \
  chmod +x /usr/local/bin/kubectl && \
  curl -o ./install_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get && \
  chmod +x ./install_helm.sh && \
  ./install_helm.sh -v ${HELM_VERSION} && \
  helm init --client-only

# Also install helm3 as `helm3`
RUN curl -s https://get.helm.sh/helm-v3.6.2-linux-"$(dpkg --print-architecture)".tar.gz | sudo tar -C /tmp --no-same-owner -xvzf - linux-amd64/helm --strip-components 1 && \
    mv /tmp/helm /bin/helm3

# Install Kustomize
# https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
RUN cd /bin/ && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

# Install AWS cli
COPY awscli.pubkey /tmp/
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-"$(uname -m)".zip -o "awscliv2.zip" && \
  gpg --import /tmp/awscli.pubkey && \
  curl -s -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-"$(uname -m)".zip.sig && \
  gpg --verify awscliv2.sig awscliv2.zip && \
  unzip -q awscliv2.zip && \
  ./aws/install && \
  rm awscliv2.zip && rm -rf aws

# Install yq
# https://mikefarah.gitbook.io/yq/#wget
RUN wget https://github.com/mikefarah/yq/releases/download/v4.21.1/yq_linux_"$(dpkg --print-architecture)".tar.gz -O - |\
  tar xz && mv yq_linux_amd64 /usr/bin/yq

# All further commands will be performed as the docker user.
USER docker
SHELL ["/bin/bash", "-c"]

# Install additional global npm dependencies
RUN \
  # Initialize the user environment (this loads nvm)
  . "$HOME"/.profile && \
  # Install node packages
  yarn global add puppeteer@1.20.0 pa11y@5 pa11y-ci@2 http-server

# IMPORTANT! Switching back to the root user as the last instruction.
USER root
