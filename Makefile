
all:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

re: fclean all

fclean:
	rm -rf home/sam/data/
	docker stop $$(docker ps -a -q)
	docker rmi -f $$(docker image ls -q)
	docker rm -f $$(docker ps -a -q)
	docker volume rm -f $$(docker volume ls -q)
	docker network rm -f $$(docker network ls -q)

.PHONY: all stop fclean