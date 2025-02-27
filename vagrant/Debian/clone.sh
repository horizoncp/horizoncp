# Clone HorizonCP Repository
echo "Cloning HorizonCP repository..."
cd /home/vagrant
git clone https://github.com/horizoncp/horizoncp.git > /dev/null 2>&1
cd /home/vagrant/horizoncp/web
composer install > /dev/null 2>&1
cp .env.example .env
php artisan key:generate > /dev/null 2>&1 
php artisan migrate --seed > /dev/null 2>&1
php artisan storage:link > /dev/null 2>&1
sudo cp -r /home/vagrant/horizoncp/web /var/www/
sudo chown -R www-data:www-data /var/www/web/storage
sudo chown -R www-data:www-data /var/www/web/bootstrap/cache
