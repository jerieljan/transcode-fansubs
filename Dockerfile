# transcode-fansubs-docker
# A convenience Docker image that takes ffmpeg and transcodes all files in /data
# to a defined format.

FROM alpine:3.12

# Install dumb-init and ffmpeg
RUN set -x \
 && apk add --no-cache \
        dumb-init \
        ffmpeg \
        bash \
 && mkdir /downloads \
 && chmod a+rw /downloads \
 && mkdir /.cache \
 && chmod 777 /.cache \
 && mkdir /app \
 && chmod a+rw /app

# Load the transcode-fansubs-all script.
# For the actual transcoding loop, check this file out.
COPY transcode-fansubs-all.sh /app/
RUN chmod 777 /app/transcode-fansubs-all.sh

WORKDIR /data
VOLUME ["/data"]

# Basic check
RUN dumb-init ffmpeg --help

#ENTRYPOINT [ "dumb-init", "ffmpeg" ]
#CMD ["--help"]

ENTRYPOINT [ "/app/transcode-fansubs-all.sh" ]