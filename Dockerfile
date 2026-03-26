# Usa PHP 8.3 FPM
FROM php:8.3-fpm

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    default-mysql-client \
    libonig-dev \
    && docker-php-ext-install pdo pdo_mysql zip \
    && docker-php-ext-enable pdo_mysql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia proyecto
WORKDIR /var/www/html
COPY . .

# Instala dependencias sin ejecutar scripts
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Da permisos correctos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copia entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expone puerto PHP-FPM
EXPOSE 9000

# CMD principal
CMD ["/entrypoint.sh"]