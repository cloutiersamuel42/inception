DATA_DIR = $(HOME)/data

all:
	@echo Creating volume directories in $(DATA_DIR)... ; \
	if [ ! -d $(DATA_DIR) ]; \
	then \
		mkdir $(DATA_DIR) && \
		mkdir $(DATA_DIR)/mysql && \
		mkdir $(DATA_DIR)/wordpress && \
	fi;
	
	@cd srcs ; docker compose up -d --build

down:
	@cd srcs ; docker compose down -v -t 1

fclean:
	rm -rf home/sam/data/
	docker stop $$(docker ps -a -q)
	docker rmi -f $$(docker image ls -q)
	docker rm -f $$(docker ps -a -q)
	docker volume rm -f $$(docker volume ls -q)
	docker network rm -f $$(docker network ls -q)

.PHONY: all down fclean