# Dockerfile
ARG SSH_KEY_PATH
ARG USER_EMAIL
ARG USER_NAME

# Specify base image
FROM python:3.11.6

# Set working directory
WORKDIR /usr/src/repos

# Install dependencies for MeCab and Neologd
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    git \
    make \
    curl \
    xz-utils \
    file \
    sudo \
    && \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/*

# Copy SSH key
COPY ${SSH_KEY_PATH} /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Set Git config
RUN git config --global user.email "${USER_EMAIL}"
RUN git config --global user.name "${USER_NAME}"
RUN git config --global core.autocrlf input

# Install Neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y

# Upgrade pip
RUN pip install --upgrade pip

# Install Neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y

# Install required Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . .
