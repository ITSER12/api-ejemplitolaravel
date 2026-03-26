# Dockerfile para Laravel en Railway
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

# Instala dependencias de Laravel sin ejecutar scripts aún
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Ejecuta manualmente los scripts de Laravel después de que PDO MySQL esté disponible
RUN php artisan package:discover --ansi

# Da permisos correctos
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expone el puerto
EXPOSE 8000

# Comando para arrancar Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000