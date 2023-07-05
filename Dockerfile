FROM public.ecr.aws/docker/library/golang:1.20 AS build

WORKDIR /app

COPY go.mod hello.go go.sum ./ 
ENV GOOS=linux 
ENV GOARCH=amd64
ENV CGO_ENABLED=0
RUN go build -o /bin/hello 

# lean image
FROM public.ecr.aws/lambda/provided:al2

COPY --from=build /bin/hello /hello
ENTRYPOINT ["/hello"]
