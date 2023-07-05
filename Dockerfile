FROM golang:1.20-alpine AS build

WORKDIR /app

COPY go.mod hello.go go.sum ./
RUN go build -o /bin/hello

# lean image
FROM golang:1.20-alpine

COPY --from=build /bin/hello /bin/hello
ENTRYPOINT ["/bin/hello"]
