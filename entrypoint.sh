#!/bin/sh
# entrypoint.sh

# Espera a que MySQL esté listo (opcional)
until php -r "new PDO('mysql:host=mysql.railway.internal;dbname=railway','root','juJkAoWaHajmJdpcyPgqusADsdvmDSPC');" 2>/dev/null; do
  echo "Esperando a que MySQL esté listo..."
  sleep 2
done

# Descubre paquetes Laravel
php artisan package:discover --ansi

# Migraciones automáticas (opcional)
php artisan migrate --force

# Arranca php-fpm
php-fpm