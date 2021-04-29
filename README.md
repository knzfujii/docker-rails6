# docker-rails6
```
docker-compose build
docker-compose run web rails new . --database=mysql
# Ubuntu等利用の場合
sudo chown $USER. . -R
# DB設定書き換え
sed -i -e 's/host: localhost/host: db/g' config/database.yml
docker-compose up
```

DB生成
```
docker-compose exec web rails db:create
```
