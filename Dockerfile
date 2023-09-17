FROM busybox:latest

ARG SOURCE_FOLDER=/source
ENV DEST_FOLDER=/tmp/code

WORKDIR $SOURCE_FOLDER

RUN mkdir -p $SOURCE_FOLDER
ADD . $SOURCE_FOLDER

CMD ["sh", "-c", "rm -rf $DEST_FOLDER/*; \
    cp -rp * $DEST_FOLDER; cp -rp . $DEST_FOLDER; \
    chown www-data:www-data $DEST_FOLDER -Rf"]

