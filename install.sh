sudo chown -cR 999:1000 ./src/tmp/postgres_data/
sudo chmod -cR 777 ./src/tmp/postgres_data/
docker-compose build
docker-compose run --rm web rails db:create
docker-compose run --rm web rails webpacker:install #選択肢NOを選ぶ
docker-compose down
docker-compose up
