FROM php:7.4-apache

WORKDIR /app/

RUN apt-get update \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

RUN apt-get update && apt-get install -y \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN a2enmod rewrite headers

RUN cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i "s/memory_limit = .*/memory_limit = 512M/" "$PHP_INI_DIR/php.ini" \
    && sed -i "s/post_max_size = .*/post_max_size = 128M/" "$PHP_INI_DIR/php.ini" \
    && sed -i "s/upload_max_filesize = .*/upload_max_filesize = 128M/" "$PHP_INI_DIR/php.ini"

RUN mkdir -p \
    ./storage/app \
    ./storage/framework/cache \
    ./storage/framework/sessions \
    ./storage/framework/views \
    ./storage/import \
    ./storage/logs \
  && chown -R www-data:www-data ./storage

COPY container/apache/site.conf $APACHE_CONFDIR/sites-available/000-default.conf
# RUN a2ensite 000-default

COPY . .

# Validate Apache config
# RUN /docker-entrypoint.sh -t -D DUMP_VHOSTS

ENTRYPOINT ["/app/container/entrypoint.sh"]
CMD ["/app/container/start.sh"]
