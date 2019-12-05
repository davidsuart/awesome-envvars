
FROM alpine:latest

RUN apk add --no-cache jq

COPY run.sh run.sh
COPY env_vars_from_secrets.sh env_vars_from_secrets.sh

RUN \
  chmod +x "/run.sh" && \
  chmod +x "/env_vars_from_secrets.sh"

CMD ["sh", "run.sh"]
