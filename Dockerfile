# Set python base image
FROM python:3.6.8

# Install gym-backgammon
RUN mkdir -p /app/gym-backgammon/ && \
    git clone https://github.com/dellalibera/gym-backgammon.git /app/gym-backgammon/ && \
    pip3 install -e /app/gym-backgammon/

# Install other requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt

# Set working directory
WORKDIR /app/td_gammon

# Copy sources to destination folder
COPY td_gammon ./

# Set bash as entrypoint
ENTRYPOINT [ "/bin/bash" ]
