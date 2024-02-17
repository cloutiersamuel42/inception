DATA_DIR = /home/scloutie/data

all:
	@echo Creating volume directories in $(DATA_DIR)... ; \
	if [ ! -d $(DATA_DIR) ]; \
	then \
		mkdir -p $(DATA_DIR)/mysql; \
		mkdir -p $(DATA_DIR)/wordpress; \
	fi;
	
	@cd srcs ; docker compose up --build

down:
	@cd srcs ; docker compose down -v -t 1

fclean: down
	@echo Deleting volume directories in $(DATA_DIR)... ; \
	if [ -d $(DATA_DIR) ]; \
	then \
		rm -rf $(DATA_DIR); \
	fi;

.PHONY: all down fclean