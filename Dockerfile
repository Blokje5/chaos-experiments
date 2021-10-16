FROM golang:1.16 as builder
WORKDIR /workspace
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -o sample-app main.go

FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /workspace .

ENTRYPOINT ["/sample-app"]
CMD ["--help"]