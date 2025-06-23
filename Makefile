NAME = inception

all: $(NAME)

$(NAME):
	sudo mkdir -p /home/rmoutaou
	sudo chown reda:reda /home/rmoutaou
	mkdir -p /home/rmoutaou/data
	mkdir -p /home/rmoutaou/data/database
	mkdir -p /home/rmoutaou/data/website
	echo "127.0.0.1 rmoutaou.42.fr www.rmoutaou.42.fr" | sudo tee -a /etc/hosts
	cd srcs/ && docker compose up --build

clean:
	cd srcs/ && docker compose down -v

fclean: clean
	docker system prune -a -f
	docker volume prune -f
	docker network prune -f
	docker image prune -f
	docker container prune -f
	docker builder prune -f
	sudo rm -rf /home/rmoutaou/data/database/* /home/rmoutaou/data/website/*

re: fclean all

.PHONY: all clean fclean re