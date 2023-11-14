FROM python:3.6.15-alpine

COPY . /streisand

RUN apk add --no-cache --virtual .build-deps \
    gcc musl-dev linux-headers libffi-dev curl \
 && apk --no-cache add bash git aws-cli \
 && cd /streisand \
 && ./util/venv-dependencies.sh ./venv \
 && curl -o /streisand/venv/lib/python3.6/site-packages/boto/endpoints.json 'https://raw.githubusercontent.com/boto/botocore/develop/botocore/data/endpoints.json' \
 && cp /streisand/venv/lib/python3.6/site-packages/boto/endpoints.json /streisand/venv/lib/python3.6/site-packages/botocore/data/endpoints.json \
 && apk del --no-cache .build-deps

ENTRYPOINT ["/bin/bash", "-c", "/streisand/docker-entrypoint.sh"]
