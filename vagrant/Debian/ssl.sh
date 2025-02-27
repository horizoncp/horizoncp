# Generate self-signed SSL
echo "Generating a self-signed SSL certificate..."
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/horizoncp.key \
	-x509 -days 365 -out /etc/nginx/ssl/horizoncp.crt \
	-subj "/C=US/ST=State/L=City/O=HorizonCP/CN=localhost"
