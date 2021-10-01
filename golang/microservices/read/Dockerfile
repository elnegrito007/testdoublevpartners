FROM golang:1.16-alpine

WORKDIR /read

COPY . /read

RUN go mod tidy

EXPOSE 21002

RUN go build -o /main_read

CMD [ "/main_read" ]



