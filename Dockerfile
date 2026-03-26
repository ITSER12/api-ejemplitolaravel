# Base PHP con FPM
FROM php:8.3-fpm

# Instala dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia el proyecto
WORKDIR /var/www/html
COPY . .

# Instala dependencias sin scripts (no ejecuta package:discover)
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Da permisos correctos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone puerto de php-fpm
EXPOSE 9000

# Comando principal: corre package:discover y luego php-fpm en tiempo de ejecución
CMD sh -c "php artisan package:discover --ansi && php-fpm"