# Set up MySQL
echo "Setting up MySQL..."
sudo mysql -e "CREATE DATABASE horizoncp;"
sudo mysql -e "CREATE USER 'horizoncp_user'@'localhost' IDENTIFIED BY 'horizoncp_password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON horizoncp.* TO 'horizoncp_user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
