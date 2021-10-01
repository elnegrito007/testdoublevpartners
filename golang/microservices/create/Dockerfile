FROM golang:1.16-alpine

WORKDIR /create

COPY . /create

RUN go mod tidy

EXPOSE 21000

RUN go build -o /main_create

CMD [ "/main_create" ]



