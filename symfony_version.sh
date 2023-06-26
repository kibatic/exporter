#!/bin/bash

for container in `docker ps -q`; do 
	CONTAINER=$(docker inspect --format='{{.Name}}' $container | cut -d '/' -f 2)
	HOST=$(hostname)
	SYMFONY=$(docker exec -it $container bin/console --version --no-ansi)

	if [ $? -eq 0 ]; then
		SYMFONY=$(echo $SYMFONY | cut -d ' ' -f 2)
		TEMPLATE="symfony_version{host=\"%s\", container=\"%s\"} %s\n"
		printf "$TEMPLATE" "$HOST" "$CONTAINER" "$SYMFONY"
	fi
done
