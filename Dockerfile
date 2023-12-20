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

# Install Neologd
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y

# Upgrade pip
RUN pip install --upgrade pip

# Install required Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . .
