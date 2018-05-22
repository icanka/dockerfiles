FROM alpine

ENV RUNTIME_PACKAGES ca-certificates python3 libxslt libxml2 libssl1.0
ENV BUILD_PACKAGES build-base libxslt-dev libxml2-dev libffi-dev python3-dev openssl-dev

WORKDIR /scrapyd
RUN apk add --no-cache $RUNTIME_PACKAGES && \
    update-ca-certificates && \
    apk --no-cache add --virtual build-dependencies $BUILD_PACKAGES && \
    pip3.6 --no-cache-dir install scrapyd && \
    apk del build-dependencies

COPY ./scrapyd.conf /etc/scrapyd/
EXPOSE 6800
CMD ["scrapyd"]