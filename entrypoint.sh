#!/bin/sh
# entrypoint.sh para Laravel en Railway

# Espera a que MySQL esté listo
until php -r "new PDO('mysql:host=serene-hope.railway.internal;dbname=railway','root','juJkAoWaHajmJdpcyPgqusADsdvmDSPC');" 2>/dev/null; do
  echo "Esperando a que MySQL esté listo..."
  sleep 2
done

# Descubre paquetes Laravel
php artisan package:discover --ansi

# Ejecuta migraciones automáticamente
php artisan migrate --force

# Arranca PHP-FPM (proceso principal)
php-fpm