ARG CLI_VERSION=2.12-php7.4

# Extend the Docksal CLI per https://docs.docksal.io/stack/extend-images/
FROM docksal/cli:${CLI_VERSION}

# Puppeteer dependencies taken from https://github.com/alekzonder/docker-puppeteer
# Install addtional apt packages needed for pa11y and puppeteer
# Added vim.
# --allow-releaseinfo-change per https://www.reddit.com/r/debian/comments/ca3se6/for_people_who_gets_this_error_inrelease_changed/
RUN apt-get --allow-releaseinfo-change update && \
  apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
  libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
  libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
  fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst \
  ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget vim && \
  apt-get --purge remove && \
  apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

ARG HELM_VERSION=v2.17.0

# Next install tools from phase2/docker-gitlab-ci-workspace
RUN curl -o /usr/local/bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl && \
  curl -o ./install_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get && \
  chmod +x ./install_helm.sh && \
  ./install_helm.sh -v ${HELM_VERSION} && \
  helm init --client-only

# Also install helm3 as `helm3`
RUN curl -s https://get.helm.sh/helm-v3.6.2-linux-amd64.tar.gz | sudo tar -C /tmp --no-same-owner -xvzf - linux-amd64/helm --strip-components 1 && \
    mv /tmp/helm /bin/helm3

# Install Kustomize
# https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

# AWS CLI
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install

# All further commands will be performed as the docker user.
USER docker
SHELL ["/bin/bash", "-c"]

# Remove ruby from Docksal CLI
RUN \
	# Initialize the user environment (this loads rvm)
	. $HOME/.profile && \
    rvm remove ruby-${RUBY_VERSION_INSTALL}

# Install additional global npm dependencies
RUN \
	# Initialize the user environment (this loads nvm)
	. $HOME/.profile && \
	# Install node packages
	npm install -g puppeteer@1.20.0 pa11y@5 pa11y-ci@2 http-server

# IMPORTANT! Switching back to the root user as the last instruction.
USER root
