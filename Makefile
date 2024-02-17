DATA_DIR = /home/scloutie/data

all:
	@echo Creating volume directories in $(DATA_DIR)... ; \
	if [ ! -d $(DATA_DIR) ]; \
	then \
		mkdir -p $(DATA_DIR)/mysql; \
		mkdir -p $(DATA_DIR)/wordpress; \
	fi;
	
	@cd srcs ; docker compose up

headless:
	@echo Creating volume directories in $(DATA_DIR)... ; \
	if [ ! -d $(DATA_DIR) ]; \
	then \
		mkdir -p $(DATA_DIR)/mysql; \
		mkdir -p $(DATA_DIR)/wordpress; \
	fi;
	
	@cd srcs ; docker compose up -d

down:
	@cd srcs ; docker compose down -t 1

clean: down
	@docker image prune --force
	@docker volume prune --force

fclean: down clean
	@docker image rm inception-mariadb
	@docker image rm inception-wordpress
	@docker image rm inception-nginx
	@docker volume rm inception_mariadb_data
	@docker volume rm inception_wordpress_data
	@echo Deleting volume directories in $(DATA_DIR)... ; \
	if [ -d $(DATA_DIR) ]; \
	then \
		rm -rf $(DATA_DIR); \
	fi;

re: fclean all
	@cd srcs ; docker compose up --build

.PHONY: all headless down clean fclean re