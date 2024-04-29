# clear
echo "=== INCEPTION CONFIGURATION ==="

printf "\nEnter the path where to create your mariadb database and wordpress files"
printf "\nExample : /home/fvon-nag/data\n"
read path


echo "$path" > srcs/requirements/tools/data_path.txt

# replace 'path/to/data' by the path entered by the user in srcs/docker-compose.yml
cat srcs/docker-compose.yml | sed "s+pathtodata+$path+g" > srcs/docker-compose.yml.tmp
mv srcs/docker-compose.yml.tmp srcs/docker-compose.yml