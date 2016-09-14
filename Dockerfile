FROM debian:jessie
# MAINTAINER Borja Burgos <borja@tutum.co>, Mia Iversen <mia@chillfox.com>
MAINTAINER Ryan Platte <ryan@burnbush.net>

RUN apt-get update \
 && apt-get install -y python-pip \
 && pip install awscli \
 && pip install https://bitbucket.org/dbenamy/devcron/get/tip.tar.gz

ADD backup.sh /backup.sh
ADD restore.sh /restore.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

ENV S3_BUCKET_NAME=docker-backups.example.com \
    AWS_ACCESS_KEY_ID=**DefineMe** \
    AWS_SECRET_ACCESS_KEY=**DefineMe** \
    AWS_DEFAULT_REGION=us-east-1 \
    PATHS_TO_BACKUP=/paths/to/backup \
    BACKUP_NAME=backup \
    RESTORE=false

CMD ["/run.sh"]
