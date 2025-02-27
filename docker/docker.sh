#!/bin/bash

# Define colors for better visibility
GREEN="\e[32m"
YELLOW="\e]33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${GREEN}HorizonCP Docker Automation Script${RESET}"
echo "-----------------------------------"

# Define available actions
case "$1" in
	up)
		echo -e "${YELLOW}Starting Docker containers...${RESET}"
	docker compose up -d --build
	;;

	down)
		echo -e "${YELLOW}Stopping and removing containers...${RESET}"
		docker compose down
		;;

	restart)
		echo -e "${YELLOW}Restarting Docker containers...${RESET}"
		docker compose down && docker compose up -d --build
		;;

	logs)
		echo -e "${YELLOW}Showing logs...${RESET}"
		docker compose logs -f
		;;

	shell)
		echo -e "${YELLOW}Entering the PHP container...${RESET}"
		docker exec -it horizoncp_app bash
		;;

	migrate)
		echo -e "${YELLOW}Running database migrations...${RESET}"
		docker exec -it horizoncp_app php artisan migrate --seed
		;;

	install)
		echo -e "${YELLOW}Setting up Laravel...${RESET}"
		docker exec -it horizoncp_app cp .env.example .env
		docker exec -it horizoncp_app php artisan key:generate
		docker exec -it horizoncp_app php artisan migrate --seed
		docker exec -it horizoncp_app php artisan storage:link
		echo -e "${GREEN}Setup completed successfully!${RESET}"
		;;

	reset)
		echo -e "${RED}Resetting everything! This will delete all data.${RESET}"
		read -p "Are you sure? (y/n): " confirm
		if [[ "$confirm" == "y" ]]; then
			docker compose down -v
			rm -rf vendor composer.lock
			docker compose up -d --build
			echo -e "${GREEN}Docker environment has been reset.${RESET}"
		else
			echo -e "${YELLOW}Reset canceled.${RESET}"
		fi
		;;

	*)
		echo "Usage: ./docker.sh {up|down|restart|logs|shell|migrate|install|reset}"
		;;
esac

