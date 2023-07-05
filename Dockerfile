FROM public.ecr.aws/lambda/go:1 AS build

WORKDIR /app

COPY go.mod hello.go go.sum ./
RUN go build -o /bin/hello

# lean image
FROM public.ecr.aws/lambda/provided:al2

COPY --from=build /bin/hello /hello
ENTRYPOINT ["/hello"]
