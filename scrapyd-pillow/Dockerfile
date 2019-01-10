FROM alpine

ENV RUNTIME_PACKAGES ca-certificates python3 libxslt libxml2 libssl1.0 libjpeg
ENV BUILD_PACKAGES build-base libxslt-dev libxml2-dev libffi-dev python3-dev openssl-dev jpeg-dev

RUN apk add --no-cache $RUNTIME_PACKAGES && \
    update-ca-certificates && \
    apk --no-cache add --virtual build-dependencies $BUILD_PACKAGES && \
    pip3 --no-cache-dir install --upgrade pip && \
    pip3 --no-cache-dir install scrapyd Pillow && \
    apk del build-dependencies

VOLUME /scrapyd
COPY ./scrapyd.conf /etc/scrapyd/
VOLUME /scrapyd
EXPOSE 6800
CMD ["scrapyd"]
