ARG base_image="ubuntu"
ARG base_tag="jammy"

FROM ${base_image}:${base_tag}

# Build arguments
ARG user="user"
ARG uid="22222"
ARG gid="22222"

# Setup environment
ENV DEBIAN_FRONTEND="noninteractive"

# Prepare filesystem
RUN mkdir -p /etc/apt/keyrings

# Upgrade OS packages
RUN apt-get update && \
    apt-get upgrade -yy && \
    apt-get dist-upgrade -yy && \
    apt-get autoremove -yy

# Install base dependency packages
RUN apt-get install -yy \
      apt-utils build-essential ca-certificates curl \
      gnupg lsb-release \
      python3 python3-pip python3-venv \
      screen software-properties-common tmux vim wget

# Install Ansible
RUN add-apt-repository -yy --update ppa:ansible/ansible && \
    apt-get remove -yy ansible && \
    apt-get install -yy ansible-core

# Install Docker Compose
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -yy docker-ce-cli docker-compose-plugin

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install terraform

# Add non-privileged user
RUN groupadd -g ${gid} ${user} && \
    useradd -ms /bin/bash -u ${uid} -g ${gid} ${user}

# Copy root filesystem
COPY ./rootfs/ /

# Set filesystem permissions
RUN chmod +x /opt/toolz/scripts/*.sh

# Switch to non-privileged user
USER ${user}
WORKDIR /home/${user}

CMD /opt/toolz/scripts/entrypoint.sh
