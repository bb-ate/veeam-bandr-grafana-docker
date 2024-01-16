# Pulling Alpine image
FROM alpine:latest

# Setting up work directory
WORKDIR /cron

# Updating the packages
RUN apk update && \
apk upgrade --available && sync

# Install cron, bash curl and jq - used by the script 
RUN apk --no-cache add bash
RUN apk --no-cache add curl
RUN apk --no-cache add jq

#Install tar, download and untar the influx-cli
RUN apk --no-cache add tar
ADD https://dl.influxdata.com/influxdb/releases/influxdb2-client-2.7.3-linux-amd64.tar.gz .
RUN tar -xf influxdb2-client-2.7.3-linux-amd64.tar.gz -C /usr/local/bin

# Copying script file into container 
COPY veeam_backup_and_replication.sh .

# Giving executable permission to script file
RUN chmod +x veeam_backup_and_replication.sh

# Adding crontab to the appropriate location
ADD crontab /etc/cron.d/my-cron-file

# Giving permission to crontab file
RUN chmod 0644 /etc/cron.d/my-cron-file

# Running crontab
RUN crontab /etc/cron.d/my-cron-file

# Creating entry point for cron 
ENTRYPOINT ["crond", "-f"]