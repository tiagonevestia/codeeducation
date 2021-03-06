FROM golang:alpine AS build

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build

COPY go.mod .
RUN go mod download

COPY . .
RUN go build -o main .

WORKDIR /dist

RUN cp /build/main .

FROM scratch
COPY --from=build /dist/main /
ENTRYPOINT ["/main"]