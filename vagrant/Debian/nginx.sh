# Configure Nginx
echo "Configuring Nginx..."
sudo rm /etc/nginx/sites-enabled/default
cat <<EOF | sudo tee /etc/nginx/sites-available/horizoncp
server {
	listen 80;
	listen 443 ssl;
	server_name localhost;

	ssl_certificate /etc/nginx/ssl/horizoncp.crt;
	ssl_certificate_key /etc/nginx/ssl/horizoncp.key;

	root /var/www/web/public;

	add_header X-Frame-Options "SAMEORIGIN";
	add_header X-Content-Type-Options "nosniff";

	index index.php

	charset utf-8;

	location / {
		try_files \$uri \$uri/ /index.php?\$query_string;
	}

	location = /favicon.ico { access_log off; log_not_found off; }
	location = /robots.txt  { access_log off; log_not_found off; }

	error_page 404 /index.php;

	location ~ ^/index\.php(/|$) {
		fastcgi_pass unix:/run/php/php8.2-fpm.sock;
		fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
		include fastcgi_params;
		fastcgi_hide_header X-Powered-By;
	}

	location ~ /\.(?!well-known).* {
		deny all;
	}

	location ~ /\.ht {
		deny all;
	}
}
EOF
sudo ln -s /etc/nginx/sites-available/horizoncp /etc/nginx/sites-enabled/horizoncp
sudo systemctl restart nginx
