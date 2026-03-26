#!/bin/sh
# Descubre paquetes y aplica migraciones al iniciar
php artisan package:discover --ansi
php artisan migrate --force

# Arranca php-fpm
php-fpm