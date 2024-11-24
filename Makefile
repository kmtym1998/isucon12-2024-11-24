DB_HOST:=127.0.0.1
DB_PORT:=3306
DB_USER:=isucon
DB_PASS:=isucon
DB_NAME:=isuports
MYSQL_CMD:=mysql -h$(DB_HOST) -P$(DB_PORT) -u$(DB_USER) -p$(DB_PASS) $(DB_NAME)

isuports: test go.mod go.sum *.go cmd/isuports/*
	go build -o isuports ./cmd/isuports

test:
	go test -v ./...

sql:
	sudo $(MYSQL_CMD)

.PHONY: deploy1
deploy1:
	make before
	make checkout
	make build
	sudo systemctl restart nginx
	sudo systemctl restart isuports
	sudo systemctl restart mysql

.PHONY: build
build:
	go build -o isuports
