FROM golang:buster as builder

COPY . /opt/src/act_runner
WORKDIR /opt/src/act_runner

RUN make build

FROM ubuntu:22.04 as runner
RUN apt update && apt install -y --no-install-recommends ca-certificates git && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/src/act_runner/act_runner /usr/local/bin/act_runner
COPY run.sh /opt/act/run.sh

ENTRYPOINT ["/opt/act/run.sh"]
