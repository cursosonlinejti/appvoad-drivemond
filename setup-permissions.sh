#!/bin/bash

# Configuração de permissões para o DriveMond
APP_PATH="/var/www/html"

# Garantir que www-data seja o proprietário
chown -R www-data:www-data $APP_PATH

# Configurar permissões básicas
chmod -R 755 $APP_PATH

# Configurar permissões específicas para storage e cache (comum em aplicações Laravel/PHP)
if [ -d "$APP_PATH/storage" ]; then
    chmod -R 775 $APP_PATH/storage
fi

if [ -d "$APP_PATH/bootstrap/cache" ]; then
    chmod -R 775 $APP_PATH/bootstrap/cache
fi

# Configurar permissões para arquivos específicos
if [ -f "$APP_PATH/.env" ]; then
    chmod 666 $APP_PATH/.env
    echo "Permissão .env configurada"
fi

if [ -f "$APP_PATH/routes/web.php" ]; then
    chmod 666 $APP_PATH/routes/web.php
    echo "Permissão routes/web.php configurada"
fi

# Se o diretório de módulos existir
if [ -d "$APP_PATH/Modules" ]; then
    chmod -R 775 $APP_PATH/Modules
    echo "Permissão Modules configurada"
fi

# Configurar outras pastas comuns que possam precisar de permissões de escrita
for dir in "$APP_PATH/public" "$APP_PATH/resources" "$APP_PATH/config"; do
    if [ -d "$dir" ]; then
        chmod -R 775 "$dir"
        echo "Permissão $dir configurada"
    fi
done

echo "Todas as permissões foram configuradas"