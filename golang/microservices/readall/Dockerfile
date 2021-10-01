FROM golang:1.16-alpine

WORKDIR /readall

COPY . /readall

RUN go mod tidy

EXPOSE 21003

RUN go build -o /main_readall

CMD [ "/main_readall" ]



