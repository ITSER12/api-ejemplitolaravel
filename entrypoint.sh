#!/bin/sh
# entrypoint.sh - inicializa Laravel antes de php-fpm

# Descubre paquetes Laravel
php artisan package:discover --ansi

# Aplica migraciones automáticamente (opcional)
php artisan migrate --force

# Arranca php-fpm
php-fpm