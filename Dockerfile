# Use a imagem original como base - ajuste para a imagem específica que você usava
FROM php:8.2-apache

# Instalar dependências
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libsodium-dev \
    libxml2-dev \
    unzip \
    git \
    curl

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Instalar extensões PHP necessárias
RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    pdo_mysql \
    xml \
    tokenizer \
    zip

# Configurar e instalar GD com suporte a JPEG e PNG
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Instalar sodium
RUN docker-php-ext-install sodium

# Algumas extensões já são habilitadas por padrão em PHP 8.2
# mas garantimos que estejam disponíveis
RUN docker-php-ext-enable \
    fileinfo

# Script para configurar permissões
COPY setup-permissions.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup-permissions.sh

# Entrypoint personalizado
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]