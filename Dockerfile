FROM alpine:3.23
RUN apk add --no-cache bash rsync openssh-client tar findutils curl jq coreutils

WORKDIR /app
RUN mkdir -p /app/source
RUN mkdir -p /app/destination
RUN mkdir -p /app/data
RUN mkdir -p /app/.shh
COPY . .

RUN chmod +x vault.sh
ENTRYPOINT ["./vault.sh"]
