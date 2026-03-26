# Base PHP-FPM 8.3
FROM php:8.3-fpm

# Instala dependencias y extensiones
RUN apt-get update && apt-get install -y libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia proyecto
WORKDIR /var/www/html
COPY . .

# Instala dependencias sin scripts
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Da permisos correctos a storage y bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone puerto php-fpm
EXPOSE 9000

# Copia entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# CMD principal: entrypoint
CMD ["/entrypoint.sh"]