FROM ubuntu:17.04
LABEL mantainer="info@kuralabs.io"

# -----

USER root
ENV DEBIAN_FRONTEND noninteractive

# Set the locale
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8


# Configure time zone
ENV TZ=America/Costa_Rica
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install base system software
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        ca-certificates bash-completion iproute2 curl nano tree ack-grep \
    && rm -rf /var/lib/apt/lists/*


# Install Python stack
RUN apt-get update \
    && apt-get --yes --no-install-recommends install \
        python3.6 python3.6-venv python3.6-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 100


# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py


# Create development user
RUN addgroup \
        --quiet \
        --gid 1000 \
        webaiodns \
    && adduser \
        --quiet \
        --home /home/webaiodns \
        --uid 1000 \
        --ingroup webaiodns \
        --disabled-password \
        --shell /bin/bash \
        --gecos 'Web AsyncIO DNS' \
        webaiodns \
    && usermod \
        --append \
        --groups sudo \
        webaiodns


# Install Python modules
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf ~/.cache/pip

# Install application
COPY webaiodns /usr/local/bin/webaiodns


USER webaiodns
WORKDIR /home/webaiodns
EXPOSE 8084/TCP
CMD webaiodns
