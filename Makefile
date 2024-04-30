PATH_YML = ./srcs/docker-compose.yml
MARIADB_DATA_PATH = $(HOME)/mariadb
WORDPRESS_DATA_PATH = $(HOME)/wordpress

all:
	@mkdir -p $(MARIADB_DATA_PATH)
	@mkdir -p $(WORDPRESS_DATA_PATH)
	@docker-compose -f $(PATH_YML) up -d --build

re: fclean all

stop:
	@docker-compose -f $(PATH_YML) stop

clean: stop
	@docker-compose -f $(PATH_YML) down -v

fclean: clean
	@rm -rf $(MARIADB_DATA_PATH)
	@rm -rf $(WORDPRESS_DATA_PATH)
	@docker system prune -af

.PHONY: all re stop clean fclean 
