# Container image that runs your code
FROM alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY dist/genshdoc /usr/bin/genshdoc
RUN apk add --no-cache bash git gawk

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
