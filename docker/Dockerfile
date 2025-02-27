FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
	git curl libpng-dev libjpeg-dev \
	libfreetype6-dev zip unzip \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install gd pdo_mysql bcmath

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing project files
COPY ../web .

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist

# Set file permissions
RUN chown -R www-data:www-data /var/www/storage 
RUN chown -R www-data:www-data /var/www/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
