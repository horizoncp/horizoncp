# Install Dependencies

# Update System
echo "Updating system..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get upgrade -y > /dev/null 2>&1

# Install necessary packages
echo "Installing necessary packages..."
sudo apt-get install -y \
	nginx php php-fpm php-mysql php-curl php-xml php-zip php-mbstring \
	mariadb-server git unzip composer redis supervisor openssl > /dev/null 2>&1
