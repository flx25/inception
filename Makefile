PATH_YML = ./srcs/docker-compose.yml
MARIADB_DATA_PATH = $(HOME)/data/mariadb
WORDPRESS_DATA_PATH = $(HOME)/data/wordpress

all:
	@sudo mkdir -p $(MARIADB_DATA_PATH)
	@sudo mkdir -p $(WORDPRESS_DATA_PATH)
	@docker-compose -f $(PATH_YML) up -d --build
	#To build without cache
	#@docker-compose -f $(PATH_YML) build --no-cache && docker-compose -f $(PATH_YML) up -d

re: clean all

stop:
	@docker-compose -f $(PATH_YML) stop

clean: stop
	@docker-compose -f $(PATH_YML) down -v

fclean: clean
	@sudo rm -rf $(MARIADB_DATA_PATH)
	@sudo rm -rf $(WORDPRESS_DATA_PATH)
	@docker system prune -af

reset: fclean 
	@sudo rm -rf ${HOME}/data/wordpress
	@sudo rm -rf ${HOME}/data/mariadb

.PHONY: all re stop clean fclean 
