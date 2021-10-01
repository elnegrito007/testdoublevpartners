FROM golang:1.16-alpine

WORKDIR /edit

COPY . /edit

RUN go mod tidy

EXPOSE 21001

RUN go build -o /main_edit

CMD [ "/main_edit" ]



