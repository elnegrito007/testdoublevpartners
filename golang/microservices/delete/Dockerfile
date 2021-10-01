FROM golang:1.16-alpine

WORKDIR /delete

COPY . /delete

RUN go mod tidy

EXPOSE 21004

RUN go build -o /main_delete

CMD [ "/main_delete" ]



