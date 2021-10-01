docker build --tag main_create .
docker run --publish 21000:21000 main_create

docker build --tag main_edit .
docker run --publish 21001:21001 main_edit

docker build --tag main_read .
docker run --publish 21002:21002 main_read

docker build --tag main_readall .
docker run --publish 21003:21003 main_readall

docker build --tag main_delete .
docker run --publish 21004:21004 main_delete
